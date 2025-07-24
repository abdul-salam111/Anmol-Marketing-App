import 'package:anmol_marketing/core/utils/apptoast.dart';
import 'package:anmol_marketing/core/utils/extensions.dart';
import 'package:anmol_marketing/data/exceptions/app_exceptions.dart';
import 'package:anmol_marketing/data/models/get_models/get_all_orders.dart';
import 'package:anmol_marketing/data/repositories/orders_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistoryController extends GetxController {
  var fromDate = Rxn<DateTime>();
  var toDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    fromDate.value = now.subtractDays(7);
    toDate.value = now;
  }

  String formatDate(DateTime? date) {
    if (date == null) return "Select date";
    return DateFormat("dd-MMM-yyyy").format(date);
  }

  Future<void> pickFromDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: fromDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) fromDate.value = picked;
  }

  Future<void> pickToDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: toDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) toDate.value = picked;
  }

  var isLoading = false.obs;
  RxList<GetAllOrders> getAllOrdersList = RxList<GetAllOrders>();

  Future getAllOrders() async {
    try {
      isLoading.value = true;
      getAllOrdersList.value = await OrdersRepository.getAllOrders(
        startingDate: DateFormat("yyyy-MM-dd").format(fromDate.value!),
        toDate: DateFormat("yyyy-MM-dd").format(toDate.value!),
      );
      isLoading.value = false;
    } on UnauthorizedException {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, "Please, login again and try");
    } catch (error) {
      isLoading.value = false;
      AppToasts.showErrorToast(Get.context!, error.toString());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getAllOrders();
  }
}
