import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/projects_repository.dart';
import '../../data/repositories/tasks_repository.dart';
import '../../features/admin/presentation/admin_users_screen.dart';
import '../../features/auth/presentation/auth_gate_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/projects/presentation/project_details_screen.dart';
import '../../features/projects/presentation/projects_screen.dart';
import '../../features/shell/presentation/role_shell_screen.dart';
import '../../features/tasks/presentation/tasks_screen.dart';

class AppRouter {
  AppRouter._();

  static final _authRepo = AuthRepository();
  static final _projectsRepo = ProjectsRepository();
  static final _tasksRepo = TasksRepository();

  static final router = GoRouter(
    initialLocation: '/gate',
    routes: [
      GoRoute(path: '/gate', builder: (_, __) => AuthGateScreen(authRepository: _authRepo)),
      GoRoute(path: '/login', builder: (_, __) => LoginScreen(authRepository: _authRepo)),
      GoRoute(path: '/register', builder: (_, __) => RegisterScreen(authRepository: _authRepo)),
      GoRoute(path: '/reset', builder: (_, __) => ResetPasswordScreen(authRepository: _authRepo)),
      ShellRoute(
        builder: (context, state, child) => RoleShellScreen(child: child, authRepository: _authRepo),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => DashboardScreen(authRepository: _authRepo)),
          GoRoute(
            path: '/projects',
            builder: (_, __) => ProjectsScreen(authRepository: _authRepo, projectsRepository: _projectsRepo),
          ),
          GoRoute(
            path: '/projects/:id',
            builder: (context, state) => ProjectDetailsScreen(
              projectId: state.pathParameters['id']!,
              tasksRepository: _tasksRepo,
            ),
          ),
          GoRoute(path: '/tasks', builder: (_, __) => TasksScreen(tasksRepository: _tasksRepo)),
          GoRoute(path: '/profile', builder: (_, __) => ProfileScreen(authRepository: _authRepo)),
          GoRoute(path: '/admin/users', builder: (_, __) => AdminUsersScreen(authRepository: _authRepo)),
        ],
      ),
    ],
  );
}
