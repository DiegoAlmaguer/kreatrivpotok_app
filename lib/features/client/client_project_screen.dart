// lib/features/client/client_project_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../ui/kp_tokens.dart';
import '../../widgets/kp_card.dart';
import '../../ui/widgets/kp_empty.dart';

class ClientProjectScreen extends StatefulWidget {
  final String projectId;
  final String? projectTitle;

  const ClientProjectScreen({
    super.key,
    required this.projectId,
    this.projectTitle,
  });

  @override
  State<ClientProjectScreen> createState() => _ClientProjectScreenState();
}

class _ClientProjectScreenState extends State<ClientProjectScreen> {
  final _supabase = Supabase.instance.client;

  bool _loading = true;
  String? _error;

  Map<String, dynamic>? _project;
  List<Map<String, dynamic>> _payments = const [];
  List<Map<String, dynamic>> _docs = const [];

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // --- Project
      final proj = await _supabase
          .from('projects')
          .select()
          .eq('id', widget.projectId)
          .maybeSingle();

      // maybeSingle() returns PostgrestMap? (aka Map<String, dynamic>?)
      final project = (proj == null) ? null : Map<String, dynamic>.from(proj);

      // --- Payments
      final pay = await _supabase
          .from('payments')
          .select()
          .eq('project_id', widget.projectId)
          .order('created_at', ascending: false);

      final payments = (pay is List)
          ? pay
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList()
          : <Map<String, dynamic>>[];

      // --- Documents
      final docs = await _supabase
          .from('project_documents')
          .select()
          .eq('project_id', widget.projectId)
          .order('created_at', ascending: false);

      final documents = (docs is List)
          ? docs
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList()
          : <Map<String, dynamic>>[];

      if (!mounted) return;
      setState(() {
        _project = project;
        _payments = payments;
        _docs = documents;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _openDoc(Map<String, dynamic> doc) async {
    try {
      final path = (doc['path'] ?? doc['file_path'] ?? '').toString();
      if (path.isEmpty) return;

      // If your bucket name is different — change it here
      const bucket = 'project_docs';

      final signedUrl = await _supabase.storage
          .from(bucket)
          .createSignedUrl(path, 60 * 60);

      final uri = Uri.tryParse(signedUrl);
      if (uri == null) return;

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // ignore silently in UI
    }
  }

  @override
  Widget build(BuildContext context) {
    final title =
        widget.projectTitle ?? (_project?['title']?.toString() ?? 'Проект');

    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: _load,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (_error != null)
              ? KPEmpty(
                  title: 'Ошибка загрузки',
                  subtitle: _error!,
                  action: ElevatedButton(
                    onPressed: _load,
                    child: const Text('Повторить'),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    KPCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('О проекте', style: KPText.h3),
                          KPGap.h8,
                          Text(
                            (_project?['description'] ?? '—').toString(),
                            style: KPText.body,
                          ),
                        ],
                      ),
                    ),
                    KPGap.h12,
                    Text('Оплаты', style: KPText.h3),
                    KPGap.h8,
                    if (_payments.isEmpty)
                      const KPEmpty(
                        title: 'Оплат пока нет',
                        subtitle: 'Когда появятся оплаты — они будут здесь.',
                      )
                    else
                      ..._payments.map(
                        (p) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: KPCard(
                            child: Row(
                              children: [
                                const Icon(Icons.payments_rounded,
                                    color: KPColors.accent),
                                KPGap.w12,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (p['title'] ?? 'Оплата').toString(),
                                        style: KPText.bodyStrong,
                                      ),
                                      KPGap.h4,
                                      Text(
                                        'Статус: ${(p['status'] ?? '—').toString()}',
                                        style: KPText.caption,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  (p['amount'] ?? '—').toString(),
                                  style: KPText.bodyStrong,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    KPGap.h12,
                    Text('Документы', style: KPText.h3),
                    KPGap.h8,
                    if (_docs.isEmpty)
                      const KPEmpty(
                        title: 'Документов пока нет',
                        subtitle: 'Как только добавим — они появятся здесь.',
                      )
                    else
                      ..._docs.map(
                        (d) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: KPCard(
                            onTap: () => _openDoc(d),
                            child: Row(
                              children: [
                                const Icon(Icons.description_rounded,
                                    color: KPColors.accent2),
                                KPGap.w12,
                                Expanded(
                                  child: Text(
                                    (d['title'] ??
                                            d['name'] ??
                                            'Документ')
                                        .toString(),
                                    style: KPText.bodyStrong,
                                  ),
                                ),
                                const Icon(Icons.open_in_new_rounded,
                                    color: KPColors.text3),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
    );
  }
}
