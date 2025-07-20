import 'package:anmol_marketing/core/theme/theme.dart';
import 'package:anmol_marketing/data/database/database.dart';
import 'package:anmol_marketing/routes/app_pages.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AnmolMarketingDatabase? anmolMarketingDatabase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  anmolMarketingDatabase = AnmolMarketingDatabase();
  await anmolMarketingDatabase!.initializeDatabase();
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
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
