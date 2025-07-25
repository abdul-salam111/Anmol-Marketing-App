import 'package:anmol_marketing/controllers/confirm_order_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ConfirmOrderScreen extends GetView<ConfirmOrderController> {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Get.offNamed(AppRoutes.navbar);
              },
              child: Container(
                height: 60,
                color: AppColors.appPrimaryColor,
                child: Row(
                  mainAxisAlignment: mainAxisCenter,
                  children: [
                    Icon(Iconsax.edit, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Edit",
                      style: context.bodyLargeStyle!.copyWith(
                        color: AppColors.whiteTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                await controller.createOrder();
              },
              child: Obx(
                () => Container(
                  height: 60,
                  color: Colors.green,
                  child: controller.isLoading.value == false
                      ? Row(
                          mainAxisAlignment: mainAxisCenter,
                          children: [
                            Icon(Icons.done, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Place Order",
                              style: context.bodyLargeStyle!.copyWith(
                                color: AppColors.whiteTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Center(child: LoadingIndicator(size: 30)),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: CustomAppBar(title: "Confirm Order"),
      body: Column(
        crossAxisAlignment: crossAxisStart,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: screenPadding,
            child: Text(
              "Selected Companies",
              style: context.bodySmallStyle!.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: ListView.separated(
              padding: screenPadding,
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                final order = controller.cartItems[index];
                return Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      ProductImage(
                        imageUrl: order.companyLogo,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: crossAxisStart,

                          children: [
                            Text(
                              order.companyName,
                              style: context.bodySmallStyle!.copyWith(
                                color: AppColors.blackTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: mainAxisSpaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Items: ",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "${order.totalProducts}",
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
                                      "Amount: ",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.darkGreyColor,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Rs. ${context.formatPrice(order.companyTotal)}",
                                      style: context.bodySmallStyle!.copyWith(
                                        color: AppColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),

          Container(
            padding: defaultPadding,
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(color: Color(0xffDED2FA)),
            child: Row(
              mainAxisAlignment: mainAxisSpaceAround,
              children: [
                Column(
                  crossAxisAlignment: crossAxisCenter,
                  mainAxisAlignment: mainAxisCenter,
                  children: [
                    Obx(
                      () => Text(
                        "${controller.totalProducts.value}",
                        style: context.headlineSmallStyle!.copyWith(
                          color: AppColors.blackTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Total Products",
                      style: context.displayLargeStyle!.copyWith(
                        color: AppColors.greyTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: crossAxisCenter,
                  mainAxisAlignment: mainAxisCenter,
                  children: [
                    Obx(
                      () => Text(
                        "Rs. ${context.formatPrice(controller.totalAmount.value)}",
                        style: context.headlineSmallStyle!.copyWith(
                          color: AppColors.blackTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Total Amount",
                      style: context.displayLargeStyle!.copyWith(
                        color: AppColors.greyTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
