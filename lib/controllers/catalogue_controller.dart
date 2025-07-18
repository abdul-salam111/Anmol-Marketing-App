import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CatalogueController extends GetxController {
  final searchQuery="".obs;

  RxList<CompanyModel> companies = <CompanyModel>[
    CompanyModel(
      name: 'Abbott Laboratories Pakistan',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'The Searle Company',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'Martin Dow',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'Hilton Pharma',
      logoPath:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
  ].obs;

  RxList<CompanyModel> filterCompanies = <CompanyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filterCompanies.assignAll(companies); 
    debounce(
      searchQuery.value.obs, 
      (_) => searchCompanies(searchQuery.value.trim()),
      time: const Duration(milliseconds: 300), 
    );
  }

  void searchCompanies(String query) {
    if (query.isEmpty) {
      filterCompanies.assignAll(companies);
    } else {
      final results = companies
          .where(
            (company) =>
                company.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      filterCompanies.assignAll(results);
    }
  }

  @override
  void dispose() {
    searchQuery.value;
    super.dispose();
  }
}

class CompanyModel {
  final String name;
  final String logoPath;

  CompanyModel({required this.name, required this.logoPath});

  // Implement equality so Set can work correctly
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          logoPath == other.logoPath;

  @override
  int get hashCode => name.hashCode ^ logoPath.hashCode;
}
