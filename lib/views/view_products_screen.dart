import 'package:anmol_marketing/controllers/view_products_controller.dart';
import 'package:anmol_marketing/core/core.dart';
import 'package:anmol_marketing/views/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProductsScreen extends GetView<ViewProductsController> {
  const ViewProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
              ),
              CachedNetworkImage(
                imageUrl: controller.company.logoPath,
                width: 40,
                height: 40,
              ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            controller.company.name,
            style: context.bodyLargeStyle!.copyWith(
              color: AppColors.whiteTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appPrimaryColor,
        ),
        body: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomSearchField(onChanged: controller.searchProducts),
      
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  final products = controller.filteredProducts;
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      mainAxisExtent: context.screenHeight * 0.25,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Column(
                        children: [
                          ProductImage(
                            imageUrl:
                                "https://dawailo.pk/wp-content/uploads/2021/07/Screenshot1-6.png",
                            width: context.screenWidth / 2,
                            height: context.screenHeight * 0.15,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product.name,
                            style: context.bodyMediumStyle!.copyWith(
                              color: AppColors.blackTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Pack: ",
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.darkGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    product.pack,
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "T.p: ",
                                    style: context.displayLargeStyle!.copyWith(
                                      color: AppColors.darkGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    product.tradePrice.toString(),
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
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
