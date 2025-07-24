// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProductScreen extends GetView<SelectProductController> {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              CachedNetworkImage(
                imageUrl: controller.company.companyLogo ?? "",
                width: 40,
                height: 40,
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            controller.company.companyName!,
            style: context.bodyLargeStyle!.copyWith(
              color: AppColors.whiteTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appPrimaryColor,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? LoadingIndicator()
              : controller.filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    "No products available, yet!",
                    style: context.bodySmallStyle,
                  ),
                )
              : Column(
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
                            final product =
                                controller.filteredProducts[index];
                            return InkWell(
                              onTap: () {
                                showProductDetails(context, product);
                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Row(
                                  children: [
                                    ProductImage(
                                      imageUrl: product.productLogo!,
                                    ),
                                    SizedBox(width: 10),
    
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: crossAxisStart,
    
                                        children: [
                                          Text(
                                            product.productName!,
                                            style: context.bodySmallStyle!
                                                .copyWith(
                                                  color: AppColors
                                                      .blackTextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Text(
                                                "Pack: ",
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .darkGreyColor,
                                                    ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                product.pack!,
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .blackTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
    
                                          Row(
                                            children: [
                                              Text(
                                                "Trade Price: ",
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .darkGreyColor,
                                                    ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                product.tradePrice.toString(),
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .blackTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
    
                                          Row(
                                            children: [
                                              Text(
                                                "Available Stock: ",
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .darkGreyColor,
                                                    ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                product.productStock
                                                    .toString(),
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color: AppColors
                                                          .blackTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
    
                                    Container(
                                      padding: defaultPadding,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              (controller.productQuantities[product] !=
                                                      null &&
                                                  controller
                                                          .productQuantities[product]! >
                                                      0)
                                              ? Colors.black
                                              : AppColors.darkGreyColor,
                                          width:
                                              (controller.productQuantities[product] !=
                                                      null &&
                                                  controller
                                                          .productQuantities[product]! >
                                                      0)
                                              ? 2
                                              : 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      child: Obx(
                                        () => Text(
                                          controller.productQuantities[product] ==
                                                  null
                                              ? "0"
                                              : controller
                                                    .productQuantities[product]
                                                    .toString(),
                                          style: context.bodySmallStyle!.copyWith(
                                            color:
                                                (controller.productQuantities[product] !=
                                                        null &&
                                                    controller
                                                            .productQuantities[product]! >
                                                        0)
                                                ? Colors.black
                                                : AppColors.darkGreyColor,
                                            fontWeight:
                                                (controller.productQuantities[product] !=
                                                        null &&
                                                    controller
                                                            .productQuantities[product]! >
                                                        0)
                                                ? FontWeight.bold
                                                : FontWeight.normal,
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
                      onTap: () async {
                        await controller.saveOrder();
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.appPrimaryColor,
                        ),
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
      ),
    );
  }

  void showProductDetails(BuildContext context, GetProductsModel product) {
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
                        product.productName!,
                        style: context.bodyMediumStyle!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CachedNetworkImage(
                        imageUrl: product.productLogo!,
                        height: 150,
                      ),
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
                                product.pack!,
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
                                "Rs. ${product.tradePrice.toString()}",
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
                      (product.productStock! > 0.0)
                          ? SizedBox(
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
                            )
                          : SizedBox.square(),
                      const SizedBox(height: 20),
                      (product.productStock! > 0.0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    final quantity =
                                        int.tryParse(quantityController.text) ??
                                        0;
                                    controller.updateProductQuantity(
                                      product,
                                      quantity,
                                    );

                                    Get.back();
                                  },
                                  child: const Text("Update"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.updateProductQuantity(
                                      product,
                                      0,
                                    );
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
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
