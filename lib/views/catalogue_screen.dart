import 'package:anmol_marketing/controllers/catalogue_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/routes/app_routes.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatalogueScreen extends GetView<CatalogueController> {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        drawer: Drawer(),
        appBar: CustomAppBar(title: "Catalogue"),
        body: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomSearchField(
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              ),
              SizedBox(height: 10),
              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return Expanded(
                    child: Center(child: Text(controller.errorMessage.value)),
                  );
                }

                if (controller.filterCompanies.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        controller.searchQuery.value.isEmpty
                            ? "No companies available"
                            : "No matching companies found",
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filterCompanies.length,
                    itemBuilder: (context, index) {
                      final company = controller.filterCompanies[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.viewProducts,
                              arguments: company,
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: ProductImage(
                            cacheKey: company.companyId.toString(),
                            imageUrl: company.companyLogo ?? "",
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            company.companyName ?? "",
                            style: context.bodySmallStyle!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
