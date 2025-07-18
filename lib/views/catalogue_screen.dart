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
        appBar: CustomAppBar(title: "Cataloge"),
        body: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomSearchField(
                onChanged: (value) {
                  controller.searchQuery.value = value;
                  controller.searchCompanies(value);
                },
              ),
              SizedBox(height: 10),
              Obx(
                () => Expanded(
                  child: controller.filterCompanies.isEmpty
                      ? Center(child: Text("Not found"))
                      : ListView.builder(
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
                                  imageUrl: company.logoPath,
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(
                                  company.name,
                                  style: context.bodyLargeStyle,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
