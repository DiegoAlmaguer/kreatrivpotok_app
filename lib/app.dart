// lib/app.dart
import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'ui/kp_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: KPTheme.dark(),
      routerConfig: AppRouter.router,
    );
  }
}
