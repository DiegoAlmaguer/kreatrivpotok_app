// lib/features/client/client_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../../ui/kp_tokens.dart';
import '../../widgets/kp_card.dart';
import '../../router/app_router.dart';
import 'package:go_router/go_router.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPColors.bg,
      appBar: AppBar(
        backgroundColor: KPColors.bg,
        title: const Text('Личный кабинет'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Привет 👋', style: KPText.h2),
          KPGap.h6,
          Text('Здесь — ваши проекты, оплаты и документы.', style: KPText.body),
          KPGap.h16,
          KPCard(
            onTap: () => context.go('/client/projects'),
            child: Row(
              children: [
                const Icon(Icons.folder_open_rounded, color: KPColors.accent),
                KPGap.w12,
                Expanded(
                  child: Text('Мои проекты', style: KPText.bodyStrong),
                ),
                const Icon(Icons.chevron_right_rounded, color: KPColors.text3),
              ],
            ),
          ),
          KPGap.h12,
          KPCard(
            child: Row(
              children: [
                const Icon(Icons.support_agent_rounded, color: KPColors.accent2),
                KPGap.w12,
                Expanded(
                  child: Text('Поддержка', style: KPText.bodyStrong),
                ),
                Text('в разработке', style: KPText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
