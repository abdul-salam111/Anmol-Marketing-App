import 'package:anmol_marketing/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../core/core.dart';
import 'widgets/widgets.dart';

class CreateOrderScreen extends GetView<CreateOrderController> {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: mainAxisCenter,
                children: [
                  Icon(Icons.close, color: Colors.white),
                  SizedBox(width: 10,),
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
          Expanded(
            child: Container(
              height: 60,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: mainAxisCenter,
                children: [
                  Icon(Icons.done, color: Colors.white),
                  SizedBox(width: 10,),

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
        ],
      ),
      drawer: Drawer(),
      appBar: CustomAppBar(title: "Create new order"),
      body: Column(
        crossAxisAlignment: crossAxisStart,
        children: [
          Expanded(
            child: ListView.builder(
              padding: screenPadding,
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.darkGreyColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.network(
                            controller.cartItems[index].logoPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: crossAxisStart,
                          children: [
                            Text(
                              controller.cartItems[index].name,
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
                                      style: context.displayLargeStyle!
                                          .copyWith(color: AppColors.greyColor),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      "11",
                                      style: context.displayLargeStyle!
                                          .copyWith(
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
                                      style: context.displayLargeStyle!
                                          .copyWith(color: AppColors.greyColor),
                                    ),
                                    Text(
                                      "Rs. 16,000",
                                      style: context.displayLargeStyle!
                                          .copyWith(
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
                    Text(
                      "23",
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
                      "Rs.123,000",
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
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.darkGreyColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.network(
                            controller.cartItems[index].logoPath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.cartItems[index].name,
                          style: context.bodyMediumStyle!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
