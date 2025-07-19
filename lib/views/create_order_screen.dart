import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/core.dart';
import 'widgets/widgets.dart';

class CreateOrderScreen extends GetView<CreateOrderController> {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => controller.cartItems.isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 60,
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: mainAxisCenter,
                          children: [
                            Icon(Icons.close, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Cancel",
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
                      child: Container(
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: mainAxisCenter,
                          children: [
                            Icon(Icons.done, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Checkout",
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
                ],
              )
            : SizedBox.shrink(),
      ),
      appBar: CustomAppBar(title: "Create new order"),
      body: Column(
        crossAxisAlignment: crossAxisStart,
        children: [
          Obx(
            () => controller.cartItems.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      padding: screenPadding,
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.selectProduct,
                              arguments: [
                                controller.cartItems[index].company,
                                double.parse(
                                  controller.cartItems[index].companyTotal!,
                                ),
                                controller.totalAmount,
                              ],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                ProductImage(
                                  imageUrl: controller
                                      .cartItems[index]
                                      .company!
                                      .companyLogo,
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: crossAxisStart,
                                    children: [
                                      Text(
                                        controller
                                            .cartItems[index]
                                            .company!
                                            .companyName,
                                        style: context.bodySmallStyle!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: mainAxisStart,
                                        children: [
                                          Column(
                                            crossAxisAlignment: crossAxisStart,
                                            children: [
                                              Text(
                                                "#Products",
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color:
                                                          AppColors.greyColor,
                                                    ),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                controller
                                                    .cartItems[index]
                                                    .totalProducts
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
                                          SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment: crossAxisStart,
                                            children: [
                                              Text(
                                                "Company Total",
                                                style: context
                                                    .displayLargeStyle!
                                                    .copyWith(
                                                      color:
                                                          AppColors.greyColor,
                                                    ),
                                              ),
                                              Text(
                                                "Rs. ${controller.cartItems[index].companyTotal}",
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Please, select company and add products"),
                    ),
                  ),
          ),
          SizedBox(height: 5),
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
                    Text(
                      "${controller.totalProducts.value}",
                      style: context.headlineSmallStyle!.copyWith(
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.bold,
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
                    Text(
                      "Rs. ${controller.totalAmount.value == 0 ? 0 : controller.totalAmount.value}",
                      style: context.headlineSmallStyle!.copyWith(
                        color: AppColors.blackTextColor,
                        fontWeight: FontWeight.bold,
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

          SizedBox(height: 30),
          Padding(
            padding: screenPadding,
            child: Text(
              "Select Companies",
              style: context.bodySmallStyle!.copyWith(
                color: AppColors.greyTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: screenPadding,
              itemCount: controller.companies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.selectProduct,
                        arguments: [
                          controller.companies[index],
                          controller.totalAmount,
                        ],
                      );
                    },
                    child: Row(
                      children: [
                        ProductImage(
                          imageUrl: controller.companies[index].companyLogo,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.companies[index].companyName,
                            style: context.bodySmallStyle!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
