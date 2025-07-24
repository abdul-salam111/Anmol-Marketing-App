import 'package:anmol_marketing/bindings/create_order_binding.dart';
import 'package:anmol_marketing/views/ac_statements_screen.dart';

import 'package:get/get.dart';
import '../bindings/bindings.dart';
import '../views/views.dart';
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
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.phoneVerification,
      page: () => PhoneVerificationScreen(),
      binding: PhoneVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.navbar,
      page: () => NavBarScreen(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.catalogue,
      page: () => CatalogueScreen(),
      binding: CatalogueBinding(),
    ),
    GetPage(
      name: AppRoutes.createOrder,
      page: () => CreateOrderScreen(),
      binding: CreateOrderBinding(),
    ),
    GetPage(
      name: AppRoutes.selectProduct,
      page: () => SelectProductScreen(),
      binding: SelectProductBinding(), // Create this binding class
    ),
    GetPage(
      name: AppRoutes.confirmOrder,
      page: () => ConfirmOrderScreen(),
      binding: ConfirmOrderBinding(),
    ),
    GetPage(
      name: AppRoutes.viewProducts,
      page: () => ViewProductsScreen(),
      binding: ViewProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.expiryClaim,
      page: () => ExpairyClaimScreen(),
      binding: ExpiryClaimBinding(),
    ),
    GetPage(
      name: AppRoutes.acStatements,
      page: () => AcStatementsScreen(),
      binding: AcStatementsBinding(),
    ),
  ];
}
