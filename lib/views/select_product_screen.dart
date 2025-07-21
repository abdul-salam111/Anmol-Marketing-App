// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/models/post_models/create_order.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/get_models/get_products_model.dart';

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
                  controller.searchProduct(value);
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
                            ProductImage(imageUrl: product.productImage),
                            SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: crossAxisStart,
                              children: [
                                Text(
                                  product.productName,
                                  style: context.bodySmallStyle!.copyWith(
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
                                      product.stock.toString(),
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
                                  controller.productQuantities[product]
                                      .toString(),
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
                          "Rs. ${controller.totalAmount.value}",
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
                // Get.toNamed(AppRoutes.confirmOrder);
              
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
    final int existingQty = controller.productQuantities[product] ?? 0;
    final TextEditingController quantityController = TextEditingController(
      text: existingQty > 0 ? existingQty.toString() : '',
    );

    showGeneralDialog(
      context: context,
      barrierLabel: product.productName,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (_, anim, __, ___) {
        return Transform.scale(
          scale: anim.value,
          child: Opacity(
            opacity: anim.value,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.productName,
                        style: context.bodyMediumStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CachedNetworkImage(imageUrl: product.productImage),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Pack: ",
                                style: context.bodySmallStyle!.copyWith(
                                  color: AppColors.darkGreyColor,
                                ),
                              ),
                              const SizedBox(width: 5),
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
                                "T.P: ",
                                style: context.bodySmallStyle!.copyWith(
                                  color: AppColors.darkGreyColor,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                product.tradePrice.toString(),
                                style: context.bodySmallStyle!.copyWith(
                                  color: AppColors.blackTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Enter Quantity",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final qty =
                              int.tryParse(quantityController.text) ?? 0;
                          if (qty > 0) {
                            controller.addProductQuantity(product, qty);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
