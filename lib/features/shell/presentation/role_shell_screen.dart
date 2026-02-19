import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/user_role.dart';
import '../../../../data/repositories/auth_repository.dart';

class RoleShellScreen extends StatelessWidget {
  const RoleShellScreen({
    super.key,
    required this.child,
    required this.authRepository,
  });

  final Widget child;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).matchedLocation;
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    return FutureBuilder(
      future: authRepository.loadProfile(),
      builder: (context, snapshot) {
        final role = snapshot.data?.role ?? UserRole.client;
        final destinations = _destinations(role);

        if (isDesktop) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex(path, destinations),
                  onDestinationSelected: (i) => context.go(destinations[i].path),
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final d in destinations)
                      NavigationRailDestination(icon: Icon(d.icon), label: Text(d.label)),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            ),
          );
        }

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex(path, destinations),
            onDestinationSelected: (i) => context.go(destinations[i].path),
            destinations: [
              for (final d in destinations) NavigationDestination(icon: Icon(d.icon), label: d.label),
            ],
          ),
        );
      },
    );
  }

  int _selectedIndex(String path, List<_NavItem> destinations) {
    final i = destinations.indexWhere((e) => path.startsWith(e.path));
    return i < 0 ? 0 : i;
  }

  List<_NavItem> _destinations(UserRole role) {
    if (role == UserRole.admin) {
      return const [
        _NavItem('/dashboard', 'Дашборд', Icons.dashboard_rounded),
        _NavItem('/projects', 'Проекты', Icons.work_outline_rounded),
        _NavItem('/admin/users', 'Пользователи', Icons.admin_panel_settings_outlined),
        _NavItem('/profile', 'Профиль', Icons.person_outline_rounded),
      ];
    }

    return const [
      _NavItem('/dashboard', 'Дашборд', Icons.dashboard_rounded),
      _NavItem('/projects', 'Проекты', Icons.work_outline_rounded),
      _NavItem('/tasks', 'Задачи', Icons.checklist_rounded),
      _NavItem('/profile', 'Профиль', Icons.person_outline_rounded),
    ];
  }
}

class _NavItem {
  const _NavItem(this.path, this.label, this.icon);

  final String path;
  final String label;
  final IconData icon;
}
