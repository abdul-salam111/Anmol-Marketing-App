import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  final List<CardModel> cardItems = [
    CardModel(
      cardColor: const Color(0xffC256E4).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Iconsax.shopping_cart,
      cardName: "Create Order",
      onTap: () {
       
      },
    ),
    CardModel(
      cardColor: const Color(0xffFFD54A).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Iconsax.card_edit,
      cardName: "Expiry Claims",
      onTap: () {},
    ),
    CardModel(
      cardColor: const Color(0xffFF8587).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Iconsax.category,
      cardName: "Product Catalog",
      onTap: () {},
    ),
    CardModel(
      cardColor: const Color(0xff81C784).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Icons.assessment,
      cardName: "Reports",
      onTap: () {},
    ),
    CardModel(
      cardColor: const Color(0xff4FC3F7).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Icons.settings,
      cardName: "Settings",
      onTap: () {},
    ),
    CardModel(
      cardColor: const Color(0xffBA68C8).withAlpha(((0.7) * 255).toInt()),
      cardIcon: Icons.support_agent,
      cardName: "Support",
      onTap: () {},
    ),
  ];
}

class CardModel {
  final Color cardColor;
  final IconData cardIcon;
  final String cardName;
  final VoidCallback onTap;

  CardModel({
    required this.cardColor,
    required this.cardIcon,
    required this.cardName,
    required this.onTap,
  });
}
