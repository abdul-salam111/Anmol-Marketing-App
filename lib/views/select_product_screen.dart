// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/models/get_models/cart_product.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProductScreen extends GetView<SelectProductController> {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: CustomAppBar(title: "Select Products"),
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: screenPadding,
              child: CustomSearchField(
                onChanged: (value) {
                  controller.searchProducts(value);
                },
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Expanded(
                child: ListView.separated(
                  padding: screenPadding,
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return InkWell(
                      onTap: () {
                        showProductDetails(context, product);
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            ProductImage(
                              imageUrl:
                                  "https://dawailo.pk/wp-content/uploads/2021/07/Screenshot1-6.png",
                            ),
                            SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: crossAxisStart,
                              children: [
                                Text(
                                  product.name,
                                  style: context.bodyMediumStyle!.copyWith(
                                    color: AppColors.blackTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Pack: ",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      product.pack,
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Text(
                                      "Trade Price: ",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      product.tradePrice.toString(),
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Available Stock: ",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      product.availableStock.toString(),
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),

                            Container(
                              padding: defaultPadding,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.darkGreyColor,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Obx(
                                () => Text(
                                  product.quantity.toString(),
                                  style: context.bodySmallStyle!.copyWith(
                                    color: AppColors.darkGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: AppColors.darkGreyColor);
                  },
                ),
              ),
            ),

            Container(
              padding: padding14,
              height: 90,
              width: double.infinity,
              color: AppColors.appSecondaryColor,
              child: Row(
                mainAxisAlignment: mainAxisSpaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: crossAxisStart,
                    children: [
                      Text(
                        "Company Total",
                        style: context.bodyMediumStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Order Total",
                        style: context.bodyMediumStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.appPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: crossAxisStart,
                    children: [
                      Obx(
                        () => Text(
                          "Rs. ${controller.companyTotal.value}",
                          style: context.bodyMediumStyle!.copyWith(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => Text(
                          "Rs. ${controller.orderTotal.value}",
                          style: context.bodyMediumStyle!.copyWith(
                            color: AppColors.appPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.confirmOrder);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.appPrimaryColor),
                child: Center(
                  child: Text(
                    "Add",
                    style: context.bodyLargeStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appLightThemeBackground,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showProductDetails(BuildContext context, Product product) {
    final controller = Get.find<SelectProductController>();

    showGeneralDialog(
      context: context,
      barrierLabel: product.name,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (_, anim, __, ___) {
        return Transform.scale(
          scale: anim.value,
          child: Opacity(
            opacity: anim.value,
            child: Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: context.bodyMediumStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ProductImage(
                      imageUrl:
                          "https://dawailo.pk/wp-content/uploads/2021/07/Screenshot1-6.png",
                      width: context.screenWidth * 0.25,
                      height: context.screenHeight * 0.2,
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () =>
                                controller.decreaseQuantity(product),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.quantity.value.toString(),
                              style: context.bodyMediumStyle!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () =>
                                controller.increaseQuantity(product),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addToCart(
                          CartProducts(
                            productId: product.name,
                            productImage:
                                "https://dawailo.pk/wp-content/uploads/2021/07/Screenshot1-6.png",
                            productName: product.name,
                            productQuantity: product.quantity.value.toString(),
                            totalAmount: controller.orderTotal.value.toString(),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
