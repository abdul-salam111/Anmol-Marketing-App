// ignore_for_file: deprecated_member_use

import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/data/models/get_models/get_products.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                            final product = controller.filteredProducts[index];
                            return InkWell(
                              onTap: () {
                                showProductDetailsBottomSheet(context, product);
                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Row(
                                  children: [
                                    ProductImage(
                                      imageUrl: product.productLogo!,
                                      cacheKey: product.productId.toString(),
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
                                                  color:
                                                      AppColors.blackTextColor,
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
                                                "Rs. ${context.formatPrice(product.tradePrice!)}",

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
                                                product.productStock!
                                                    .round()
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

                                    Obx(
                                      () => Container(
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
                                        child: Text(
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
                                  "Rs. ${context.formatPrice(controller.companyTotal.value)}",
                                  style: context.bodyMediumStyle!.copyWith(),
                                ),
                              ),
                              SizedBox(height: 10),
                              Obx(
                                () => Text(
                                  "Rs. ${context.formatPrice(controller.totalAmount.value)}",
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

  void showProductDetailsBottomSheet(
    BuildContext context,
    GetProductsModel product,
  ) {
    final int existingQty = controller.productQuantities[product] ?? 0;
    final TextEditingController quantityController = TextEditingController(
      text: existingQty > 0 ? existingQty.toString() : '',
    );
    final RxString errorText = ''.obs;
    final RxBool isValid = true.obs;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.productName ?? '',
                  style: context.bodyMediumStyle!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CachedNetworkImage(
                  cacheKey: product.productId.toString(),
                  imageUrl: product.productLogo ?? '',
                  height: 150,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Pack: ${product.pack}",
                      style: context.bodySmallStyle,
                    ),
                    Text(
                      "T.P: Rs. ${product.tradePrice}",
                      style: context.bodySmallStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Available Stock: ", style: context.bodySmallStyle),
                    Text(
                      "${product.productStock!.toInt()}",
                      style: context.bodySmallStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Column(
                    children: [
                      TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                            product.productStock!.toInt().toString().length,
                          ),
                        ],
                        onChanged: (val) {
                          final int qty = int.tryParse(val.trim()) ?? 0;
                          if (qty > product.productStock!.toInt()) {
                            errorText.value =
                                'You cannot enter more than available stock.';
                            isValid.value = false;
                          } else {
                            errorText.value = '';
                            isValid.value = true;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          labelStyle: context.bodySmallStyle,
                          labelText: "Enter Quantity",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorText: errorText.value.isEmpty
                              ? null
                              : errorText.value,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: isValid.value
                            ? () {
                                final int quantity =
                                    int.tryParse(
                                      quantityController.text.trim(),
                                    ) ??
                                    0;
                                if (quantity > product.productStock!) {
                                  Get.snackbar(
                                    "Error",
                                    "Quantity exceeds available stock.",
                                  );
                                  return;
                                }
                                controller.updateProductQuantity(
                                  product,
                                  quantity,
                                );
                                Get.back();
                              }
                            : null,
                        child: const Text("Update"),
                      ),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
