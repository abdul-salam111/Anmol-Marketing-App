// ignore_for_file: deprecated_member_use
import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavBarScreen extends GetView<NavbarController> {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Get.find<NavbarController>().currentIndex.value=0;
      },
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
              if (index == 1) {
                Get.find<CatalogueController>().fetchCompanies();
              } else if (index == 2) {
                Get.find<CreateOrderController>().fetchCompanies();
              }
              else if(index==3){
                Get.find<OrderHistoryController>().getAllOrders();
              }
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
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
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
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
