// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/client/client_dashboard_screen.dart';
import '../features/client/client_projects_tab.dart';
import '../features/client/client_project_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/client',
    routes: [
      GoRoute(
        path: '/client',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ClientDashboardScreen()),
      ),
      GoRoute(
        path: '/client/projects',
        pageBuilder: (context, state) =>
            const MaterialPage(child: ClientProjectsTab()),
      ),
      GoRoute(
        path: '/client/projects/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final title = (state.extra is String) ? state.extra as String : null;
          return MaterialPage(
            child: ClientProjectScreen(projectId: id, projectTitle: title),
          );
        },
      ),
    ],
  );
}
