import 'package:anmol_marketing/controllers/catalogue_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
              TextField(
                style:  context.bodyMediumStyle!.copyWith(color: AppColors.greyColor),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: context.bodyMediumStyle!.copyWith(color: AppColors.greyColor),
                  prefixIcon: Icon(
                    Iconsax.search_normal,
                    color: AppColors.greyColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.darkGreyColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.darkGreyColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColors.greyColor),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.companies.length,
                  itemBuilder: (context, index) {
                    final company = controller.companies[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.darkGreyColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.network(
                              company.logoPath,
                              fit: BoxFit.contain,
                            ),
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
