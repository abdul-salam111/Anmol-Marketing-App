// To parse this JSON data, do
//
//     final getCompaniesModel = getCompaniesModelFromJson(jsonString);

import 'dart:convert';

List<GetProductsModel> getCompaniesModelFromJson(String str) => List<GetProductsModel>.from(json.decode(str).map((x) => GetProductsModel.fromJson(x)));

String getCompaniesModelToJson(List<GetProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProductsModel {
    final int? productId;
    final String? productName;
    final String? productLogo;
    final double? productStock;
    final double? tradePrice;
    final double? salePrice;
    final String? pack;

    GetProductsModel({
        this.productId,
        this.productName,
        this.productLogo,
        this.productStock,
        this.tradePrice,
        this.salePrice,
        this.pack,
    });

    GetProductsModel copyWith({
        int? productId,
        String? productName,
        String? productLogo,
        double? productStock,
        double? tradePrice,
        double? salePrice,
        String? pack,
    }) => 
        GetProductsModel(
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            productLogo: productLogo ?? this.productLogo,
            productStock: productStock ?? this.productStock,
            tradePrice: tradePrice ?? this.tradePrice,
            salePrice: salePrice ?? this.salePrice,
            pack: pack ?? this.pack,
        );

    factory GetProductsModel.fromJson(Map<String, dynamic> json) => GetProductsModel(
        productId: json["ProductId"],
        productName: json["ProductName"],
        productLogo: json["ProductLogo"],
        productStock: json["ProductStock"],
        tradePrice: json["TradePrice"],
        salePrice: json["SalePrice"],
        pack: json["Pack"],
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "ProductName": productName,
        "ProductLogo": productLogo,
        "ProductStock": productStock,
        "TradePrice": tradePrice,
        "SalePrice": salePrice,
        "Pack": pack,
    };
}
