import 'package:anmol_marketing/core/core.dart';

import 'package:anmol_marketing/views/widgets/custom_appbar.dart';
import 'package:anmol_marketing/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../controllers/controllers.dart';

class OrdersHistoryScreen extends GetView<OrderHistoryController> {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Order History"),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: screenPadding,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.dialog(_buildDateFilterPopup());
                  },
                  child: Icon(Iconsax.document_filter),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Obx(() {
                    final from = controller.formatDate(
                      controller.fromDate.value,
                    );
                    final to = controller.formatDate(controller.toDate.value);

                    return Text(
                      "Showing orders from $from to $to",
                      style: context.displayLargeStyle!.copyWith(
                        color: AppColors.blackTextColor,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "No",
                    style: context.bodySmallStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Date",
                      style: context.bodySmallStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Amount",
                    style: context.bodySmallStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: context.screenWidth * 0.1),
                    child: Text(
                      "Status",
                      style: context.bodySmallStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Divider(height: 0, thickness: 2, color: Colors.black),
          ),

          Obx(
            () => controller.isLoading.value
                ? Expanded(child: Center(child: LoadingIndicator()))
                : controller.getAllOrdersList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.getAllOrdersList.length,
                      itemBuilder: (context, index) {
                        final order = controller.getAllOrdersList[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "${order.orderId}",
                                  style: context.displayLargeStyle!,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    DateFormat(
                                      "dd-MMM-yyyy",
                                    ).format(order.docDate!).toString(),
                                    style: context.displayLargeStyle!,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text(
                                    "${order.amount}",
                                    style: context.displayLargeStyle!,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.amber,

                                      padding: EdgeInsets.all(5),
                                      child: Center(
                                        child: Text(
                                          order.status.toString(),
                                          style: context.displayMediumStyle!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        "No orders history exist!",
                        style: context.bodySmallStyle,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateFilterPopup() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: crossAxisStart,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Orders",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            const SizedBox(height: 20),
            Text(
              "From Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),

            Obx(
              () => GestureDetector(
                onTap: controller.pickFromDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Text(
                    "From: ${controller.formatDate(controller.fromDate.value)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
            Text(
              "To Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.pickToDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Text(
                    "To: ${controller.formatDate(controller.toDate.value)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  controller.getAllOrders();
                },
                child: const Text("Apply"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
