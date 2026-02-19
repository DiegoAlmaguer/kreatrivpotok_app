import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/utils/date_formatter.dart';

enum ProjectMode { staff, admin }

class StaffProjectScreen extends StatefulWidget {
  final String projectId;
  final ProjectMode mode;

  const StaffProjectScreen({
    super.key,
    required this.projectId,
    required this.mode,
  });

  @override
  State<StaffProjectScreen> createState() => _StaffProjectScreenState();
}

class _StaffProjectScreenState extends State<StaffProjectScreen> {
  final _supabase = Supabase.instance.client;

  final _docTitleCtrl = TextEditingController();
  final _docUrlCtrl = TextEditingController();
  final _payAmountCtrl = TextEditingController();

  String _status = 'new';
  bool _saving = false;

  @override
  void dispose() {
    _docTitleCtrl.dispose();
    _docUrlCtrl.dispose();
    _payAmountCtrl.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _loadProject() async {
    final data = await _supabase
        .from('projects')
        .select('*')
        .eq('id', widget.projectId)
        .maybeSingle();
    if (data != null) {
      _status = (data['status'] ?? 'new').toString();
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> _loadDocs() async {
    final data = await _supabase
        .from('documents')
        .select('*')
        .eq('project_id', widget.projectId)
        .order('created_at', ascending: false);
    return (data as List).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> _loadPayments() async {
    final data = await _supabase
        .from('payments')
        .select('*')
        .eq('project_id', widget.projectId)
        .order('created_at', ascending: false);
    return (data as List).cast<Map<String, dynamic>>();
  }

  Future<void> _updateStatus(String value) async {
    setState(() => _saving = true);
    try {
      await _supabase.from('projects').update({'status': value}).eq('id', widget.projectId);
      setState(() => _status = value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Статус обновлён')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addPayment() async {
    final raw = _payAmountCtrl.text.trim().replaceAll(',', '.');
    final amount = double.tryParse(raw);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введите сумму оплаты')));
      return;
    }

    setState(() => _saving = true);
    try {
      await _supabase.from('payments').insert({
        'project_id': widget.projectId,
        'amount': amount,
        'status': 'pending',
      });
      _payAmountCtrl.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Оплата добавлена')));
        setState(() {});
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addDoc() async {
    final title = _docTitleCtrl.text.trim();
    final url = _docUrlCtrl.text.trim();

    if (title.isEmpty || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Название и ссылка обязательны')));
      return;
    }

    setState(() => _saving = true);
    try {
      await _supabase.from('documents').insert({
        'project_id': widget.projectId,
        'title': title,
        'url': url,
      });
      _docTitleCtrl.clear();
      _docUrlCtrl.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Документ добавлен')));
        setState(() {});
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.mode == ProjectMode.admin;

    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? 'Проект (Admin)' : 'Проект (Staff)'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _loadProject(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final p = snap.data;
          if (p == null) return const Center(child: Text('Проект не найден'));

          final title = (p['title'] ?? 'Без названия').toString();
          final createdAt = DateFormatter.dateTimeWithRelative(p['created_at']);
          final clientId = (p['client_id'] ?? '').toString();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text('Создан: $createdAt'),
              Text('Client ID: $clientId'),
              const SizedBox(height: 16),

              // Статус
              Row(
                children: [
                  const Text('Статус:  '),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _status,
                      items: const [
                        DropdownMenuItem(value: 'new', child: Text('new')),
                        DropdownMenuItem(value: 'in_progress', child: Text('in_progress')),
                        DropdownMenuItem(value: 'done', child: Text('done')),
                        DropdownMenuItem(value: 'canceled', child: Text('canceled')),
                      ],
                      onChanged: _saving ? null : (v) => v == null ? null : _updateStatus(v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              const Divider(),

              // Оплаты
              Text('Оплаты', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _payAmountCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Сумма',
                        hintText: 'например 5000',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _saving ? null : _addPayment,
                    child: const Text('Добавить'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _loadPayments(),
                builder: (context, ps) {
                  if (!ps.hasData) return const LinearProgressIndicator();
                  final items = ps.data!;
                  if (items.isEmpty) return const Text('Оплат нет');
                  return Column(
                    children: items.map((e) {
                      final amount = e['amount']?.toString() ?? '-';
                      final st = e['status']?.toString() ?? '-';
                      final dt = DateFormatter.dateTimeWithRelative(e['created_at']);
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Сумма: $amount'),
                        subtitle: Text('Статус: $st\n$dt'),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 18),
              const Divider(),

              // Документы
              Text('Документы', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _docTitleCtrl,
                decoration: const InputDecoration(labelText: 'Название документа'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _docUrlCtrl,
                decoration: const InputDecoration(labelText: 'Ссылка на документ'),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _saving ? null : _addDoc,
                  child: const Text('Добавить документ'),
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _loadDocs(),
                builder: (context, ds) {
                  if (!ds.hasData) return const LinearProgressIndicator();
                  final items = ds.data!;
                  if (items.isEmpty) return const Text('Документов нет');
                  return Column(
                    children: items.map((e) {
                      final name = (e['title'] ?? e['name'] ?? 'Документ').toString();
                      final url = (e['url'] ?? e['file_url'] ?? '').toString();
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(name),
                        subtitle: Text(url),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
