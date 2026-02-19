// lib/features/client/client_profile_tab.dart
import 'package:flutter/material.dart';
import '../../ui/kp_tokens.dart';
import '../../widgets/kp_card.dart';

class ClientProfileTab extends StatelessWidget {
  const ClientProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: const Text('Профиль'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          KPCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Данные пользователя', style: KPText.h3),
                KPGap.h8,
                Text('Email: —', style: KPText.body),
                KPGap.h4,
                Text('Телефон: —', style: KPText.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
