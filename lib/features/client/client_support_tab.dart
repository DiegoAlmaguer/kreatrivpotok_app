// lib/features/client/client_support_tab.dart
import 'package:flutter/material.dart';
import '../../ui/kp_tokens.dart';
import '../../ui/widgets/kp_empty.dart';

class ClientSupportTab extends StatelessWidget {
  const ClientSupportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: const Text('Поддержка'),
      ),
      body: const KPEmpty(
        title: 'Поддержка',
        subtitle: 'Скоро здесь будет чат/форма обращения.',
      ),
    );
  }
}
