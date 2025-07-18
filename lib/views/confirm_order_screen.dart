import 'package:anmol_marketing/controllers/confirm_order_controller.dart';
import 'package:anmol_marketing/core/core.dart';
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
          Expanded(
            child: Container(
              height: 60,
              color: Colors.green,
              child: Row(
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Container(
                        padding: padding5,
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.darkGreyColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.network(
                            "https://dawailo.pk/wp-content/uploads/2021/07/Screenshot1-6.png",
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
                              "product.name",
                              style: context.bodyMediumStyle!.copyWith(
                                color: AppColors.blackTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10,),
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
                                     "5",
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
                                     "Rs. 16000",
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
         
        ],
      ),
    );
  }
}
