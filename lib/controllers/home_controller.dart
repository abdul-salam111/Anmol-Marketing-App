import 'package:anmol_marketing/controllers/navbar_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends GetxController {
  final NavbarController navbarController = Get.find<NavbarController>();

  late final List<CardModel> cardItems;

  @override
  void onInit() {
    super.onInit();
    cardItems = [
      CardModel(
        cardColor: const Color(0xffC256E4).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.createorder,
        cardName: "Create Order",
        onTap: () {
          navbarController.currentIndex.value = 2;
        },
        textColor: const Color(0xffC256E4),
      ),
      CardModel(
        cardColor: const Color(0xffFFD54A).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.claimicon,
        cardName: "Expiry Claims",
        onTap: () {
          
        },
        textColor: Colors.orange,
      ),
      CardModel(
        cardColor: const Color(0xff4FC3F7).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.myorders,
        cardName: "My Orders",
        onTap: () {
          navbarController.currentIndex.value = 3;
        },
        textColor: const Color(0xff4FC3F7),
      ),
      CardModel(
        cardColor: const Color(0xffFF8587).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.profileicon,
        cardName: "My Profile",
        onTap: () {
          navbarController.currentIndex.value = 4;
        },
        textColor: const Color(0xffFF8587),
      ),
      CardModel(
        cardColor: const Color(0xff81C784).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.statementsicon,
        cardName: "A/C Statements",
        onTap: () {},
        textColor: const Color(0xff81C784),
      ),
      CardModel(
        cardColor: const Color(0xffBA68C8).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.catalogicon,
        cardName: "Product Catalog",
        onTap: () {
          navbarController.currentIndex.value = 1;
        },
        textColor: const Color(0xffBA68C8),
      ),
    ];
  }
}

class CardModel {
  final Color cardColor;
  final String cardIcon;
  final String cardName;
  final VoidCallback onTap;
  final Color textColor;

  CardModel({
    required this.cardColor,
    required this.cardIcon,
    required this.cardName,
    required this.onTap,
    required this.textColor,
  });
}
