// lib/features/client/client_payments_tab.dart
import 'package:flutter/material.dart';
import '../../ui/kp_tokens.dart';
import '../../widgets/kp_card.dart';
import '../../ui/widgets/kp_empty.dart';

class ClientPaymentsTab extends StatelessWidget {
  const ClientPaymentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = const <Map<String, String>>[];

    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: const Text('Оплаты'),
      ),
      body: payments.isEmpty
          ? const KPEmpty(
              title: 'Оплат пока нет',
              subtitle: 'Здесь будут отображаться ваши оплаты по проектам.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: payments.length,
              itemBuilder: (context, i) {
                final p = payments[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KPCard(
                    child: Text(p.toString(), style: KPText.body),
                  ),
                );
              },
            ),
    );
  }
}
