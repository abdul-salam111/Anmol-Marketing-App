import 'dart:convert';
import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products_model.dart';
import 'package:flutter/services.dart' show rootBundle;


class DataService {
  // Load JSON data from a local file (or API in real apps)
  Future<Map<String, dynamic>> _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    return json.decode(jsonString);
  }

  // Fetch all companies
  Future<List<Company>> getCompanies() async {
    final jsonData = await _loadJsonData();
    final companiesJson = jsonData['companies'] as List;
    return companiesJson.map((company) => Company.fromJson(company)).toList();
  }

  // Fetch products by companyId
  Future<List<Product>> getCompanyProducts(int companyId) async {
    final jsonData = await _loadJsonData();
    final productsJson = jsonData['products'] as List;
    return productsJson
        .where((product) => product['companyId'] == companyId)
        .map((product) => Product.fromJson(product))
        .toList();
  }
}