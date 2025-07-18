import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';

class NavBarScreen extends GetView<NavbarController> {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.appLightThemeBackground,
      //   elevation:0 ,
      //   onPressed: () {},
      //   child: Container(
      //     width: 50,
      //     height: 50,
      //     decoration: BoxDecoration(
      //       color: AppColors.appLightThemeBackground,
      //       border: Border.all(color: AppColors.appPrimaryColor),
      //       borderRadius: BorderRadius.circular(50),
      //     ),
      //     child: Icon(Iconsax.add, size: 30, color: AppColors.appPrimaryColor),
      //   ),
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
          },
          selectedItemColor: AppColors.appPrimaryColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: AppColors.appLightThemeBackground,

          items: [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.category),
              label: "Cataloge",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.appLightThemeBackground,
                  border: Border.all(color: AppColors.appPrimaryColor),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Iconsax.add,
                  size: 30,
                  color: AppColors.appPrimaryColor,
                ),
              ),
              label: "Add Order",
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.clock),
              label: "History",
            ),
            BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: [
            HomeScreen(),
            CatalogueScreen(),
            CreateOrderScreen(),
            OrdersHistoryScreen(),
          ],
        ),
      ),
    );
  }
}
