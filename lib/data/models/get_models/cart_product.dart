// To parse this JSON data, do
//
//     final cartProducts = cartProductsFromJson(jsonString);

import 'dart:convert';

CartProducts cartProductsFromJson(String str) => CartProducts.fromJson(json.decode(str));

String cartProductsToJson(CartProducts data) => json.encode(data.toJson());

class CartProducts {
    final String? productId;
    final String? productImage;
    final String? productName;
    final String? productQuantity;
    final String? totalAmount;

    CartProducts({
        this.productId,
        this.productImage,
        this.productName,
        this.productQuantity,
        this.totalAmount,
    });

    CartProducts copyWith({
        String? productId,
        String? productImage,
        String? productName,
        String? productQuantity,
        String? totalAmount,
    }) => 
        CartProducts(
            productId: productId ?? this.productId,
            productImage: productImage ?? this.productImage,
            productName: productName ?? this.productName,
            productQuantity: productQuantity ?? this.productQuantity,
            totalAmount: totalAmount ?? this.totalAmount,
        );

    factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
        productId: json["productId"],
        productImage: json["productImage"],
        productName: json["productName"],
        productQuantity: json["productQuantity"],
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productImage": productImage,
        "productName": productName,
        "productQuantity": productQuantity,
        "totalAmount": totalAmount,
    };
}
