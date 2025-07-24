import 'package:anmol_marketing/controllers/navbar_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/data/models/get_models/get_last_order.dart';
import 'package:anmol_marketing/data/repositories/orders_repository.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class HomeController extends GetxController {
  final getLastOrderModel = GetLastOrderModel().obs;
  var isLoading = false.obs;

  Future<void> getLastOrder() async {
    try {
      isLoading.value = true;
      getLastOrderModel.value = await OrdersRepository.getLastOrder();
      isLoading.value = false;
    } on UnauthorizedException {
      isLoading.value = false;

      AppToasts.showErrorToast(Get.context!, "Please, login again and try");
    } catch (error) {
      isLoading.value = false;

      print(error);
    }
  }

  final NavbarController navbarController = Get.find<NavbarController>();

  late final List<CardModel> cardItems;

  @override
  void onInit() {
    super.onInit();
    getLastOrder();
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
          Get.toNamed(AppRoutes.expiryClaim);
        },
        textColor: Colors.orange,
      ),
      CardModel(
        cardColor: const Color.fromARGB(
          255,
          12,
          90,
          225,
        ).withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.myorders,
        cardName: "My Orders",
        onTap: () {
          navbarController.currentIndex.value = 3;
        },
        textColor: const Color.fromARGB(255, 12, 90, 225),
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
        onTap: () {
          Get.toNamed(AppRoutes.acStatements);
        },
        textColor: const Color(0xff81C784),
      ),
      CardModel(
        cardColor: Colors.cyan.withAlpha(((0.3) * 255).toInt()),
        cardIcon: AppIcons.catalogicon,
        cardName: "Product Catalog",
        onTap: () {
          navbarController.currentIndex.value = 1;
        },
        textColor: Colors.cyan,
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
