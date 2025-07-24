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
    return UnfocusWrapper(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => controller.cartItems.isNotEmpty
              ? Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _confirmClearAllOrders();
                        },
                        child: Container(
                          height: 50,
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
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.confirmOrder,
                            arguments: [
                              controller.cartItems,
                              controller.totalAmount.value,
                              controller.totalProducts.value,
                            ],
                          );
                        },
                        child: Container(
                          height: 50,
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
            // SizedBox(height: 10
    
            // ),
    
            // Padding(
            //   padding: screenPadding,
            //   child: SizedBox(
            //     height: 40,
            //     child: CustomSearchField(
            //       onChanged: (value) {
            //         controller.searchQuery.value = value;
            //       },
            //     ),
            //   ),
            // ),
            _buildOrdersList(),
    
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
                          "Rs. ${controller.totalAmount.value == 0 ? 0 : controller.totalAmount.value}",
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
    
            SizedBox(height: 10),
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
            SizedBox(height: 10),
    
            Padding(
              padding: screenPadding,
              child: SizedBox(
                height: 40,
                child: CustomSearchField(
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.filterCompanies.isNotEmpty
                    ? ListView.builder(
                        padding: screenPadding,
                        itemCount: controller.filterCompanies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.selectProduct,
                                  arguments: [
                                    controller.filterCompanies[index],
                                    controller.totalAmount,
                                  ],
                                );
                              },
                              child: Row(
                                children: [
                                  ProductImage(
                                    imageUrl:
                                        controller
                                            .filterCompanies[index]
                                            .companyLogo ??
                                        "",
                                    width: 40,
                                    height: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      controller
                                              .filterCompanies[index]
                                              .companyName ??
                                          "",
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
                      )
                    : Text("Company not found!"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.cartItems.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Please, select company and add products."),
          ),
        );
      }

      return Expanded(
        child: ListView.builder(
          padding: screenPadding,
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final order = controller.cartItems[index];
            return InkWell(
              onTap: () {
                Get.toNamed(
                  AppRoutes.selectProduct,
                  arguments: [order, controller.totalAmount],
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
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
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    order.totalProducts.toString(),
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.blackTextColor,
                                      fontWeight: FontWeight.bold,
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
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Rs. ${order.companyTotal}",
                                    style: context.displayLargeStyle!.copyWith(
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
              ),
            );
          },
        ),
      );
    });
  }

  void _confirmClearAllOrders() {
    Get.dialog(
      AlertDialog(
        title: Text('Clear All Orders'),
        content: Text(
          'Are you sure you want to delete ALL orders? This cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();

              await controller.deleteAllOrder();
            },
            child: Text('Delete All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
