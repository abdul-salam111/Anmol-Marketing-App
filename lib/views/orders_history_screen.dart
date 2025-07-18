import 'package:anmol_marketing/core/core.dart';

import 'package:anmol_marketing/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
                      style: context.bodySmallStyle!.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: screenPadding,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "No",
                    style: context.bodyMediumStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Date",
                      style: context.bodyMediumStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Amount",
                    style: context.bodyMediumStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Status",
                      style: context.bodyMediumStyle!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 0),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20, left: 14, right: 14),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${index + 1}",
                          style: context.bodySmallStyle!,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            "21-Oct-2025",
                            style: context.bodySmallStyle!,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("1255000", style: context.bodySmallStyle!),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "In-Progress",
                          style: context.bodySmallStyle!,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
