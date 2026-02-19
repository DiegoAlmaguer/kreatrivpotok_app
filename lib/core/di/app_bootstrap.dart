import 'package:supabase_flutter/supabase_flutter.dart';

import '../env/app_env.dart';

class AppBootstrap {
  AppBootstrap._();

  static final AppBootstrap instance = AppBootstrap._();

  Future<void> init() async {
    await AppEnv.load();
    AppEnv.validate();

    await Supabase.initialize(
      url: AppEnv.supabaseUrl,
      anonKey: AppEnv.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
    );
  }
}
