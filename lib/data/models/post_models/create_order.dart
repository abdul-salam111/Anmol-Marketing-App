import 'dart:convert';

import 'package:anmol_marketing/data/models/get_models/get_companies.dart';
import 'package:anmol_marketing/data/models/get_models/get_products_model.dart';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  Company? company;
  String? companyTotal;
  String? totalProducts;
  List<Product> products;

  OrdersModel({
    this.company,
    this.companyTotal,
    this.totalProducts,
    required this.products,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        company: json["company"] != null ? Company.fromJson(json["company"]) : null,
        companyTotal: json["companyTotal"],
        totalProducts: json["totalProducts"],
        products: json["products"] != null
            ? List<Product>.from(json["products"].map((x) => Product.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "company": company?.toMap(),
        "companyTotal": companyTotal,
        "totalProducts": totalProducts,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
