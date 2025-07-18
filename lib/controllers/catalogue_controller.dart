import 'package:get/get.dart';

class CatalogueController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   

  }
  final List<CompanyModel> companies = [
    CompanyModel(
      name: 'Abbott Laboratories Pakistan',
      logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'The Searle Company',
      logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(name: 'Martin Dow', logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s'),
    CompanyModel(
      name: 'Hilton Pharma',
      logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(
      name: 'The Searle Company',
      logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
    CompanyModel(name: 'Martin Dow', logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s'),
    CompanyModel(
      name: 'Hilton Pharma',
      logoPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSbeemE5naktU6rb9CIWxnRcdt8Lhxye-UgQ&s',
    ),
  ];
}

class CompanyModel {
  final String name;
  final String logoPath; // Path to the asset image

  CompanyModel({required this.name, required this.logoPath});
}
