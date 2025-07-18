import 'package:anmol_marketing/core/theme/theme.dart';
import 'package:anmol_marketing/routes/app_pages.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anmol Marketing App',
      theme: AppThemes.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: AppThemes.darkTheme,
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
