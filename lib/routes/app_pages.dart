import 'package:get/get.dart';
import '../bindings/splash_binding.dart';
import '../bindings/login_binding.dart';
import '../views/splash_screen.dart';
import '../views/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
