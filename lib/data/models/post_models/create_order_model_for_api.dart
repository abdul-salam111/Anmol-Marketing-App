// To parse this JSON data, do
//
//     final createOrderModelApi = createOrderModelApiFromJson(jsonString);

import 'dart:convert';

CreateOrderModelApi createOrderModelApiFromJson(String str) => CreateOrderModelApi.fromJson(json.decode(str));

String createOrderModelApiToJson(CreateOrderModelApi data) => json.encode(data.toJson());

class CreateOrderModelApi {
    final int? paymentModeId;
    final List<Row>? rows;

    CreateOrderModelApi({
        this.paymentModeId,
        this.rows,
    });

    CreateOrderModelApi copyWith({
        int? paymentModeId,
        List<Row>? rows,
    }) => 
        CreateOrderModelApi(
            paymentModeId: paymentModeId ?? this.paymentModeId,
            rows: rows ?? this.rows,
        );

    factory CreateOrderModelApi.fromJson(Map<String, dynamic> json) => CreateOrderModelApi(
        paymentModeId: json["PaymentModeId"],
        rows: json["Rows"] == null ? [] : List<Row>.from(json["Rows"]!.map((x) => Row.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "PaymentModeId": paymentModeId,
        "Rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
    };
}

class Row {
    final int? productId;
    final int? qty;
    final double? price;
    final double? discRatio;
    final double? discValue;

    Row({
        this.productId,
        this.qty,
        this.price,
        this.discRatio,
        this.discValue,
    });

    Row copyWith({
        int? productId,
        int? qty,
        double? price,
        double? discRatio,
        double? discValue,
    }) => 
        Row(
            productId: productId ?? this.productId,
            qty: qty ?? this.qty,
            price: price ?? this.price,
            discRatio: discRatio ?? this.discRatio,
            discValue: discValue ?? this.discValue,
        );

    factory Row.fromJson(Map<String, dynamic> json) => Row(
        productId: json["ProductId"],
        qty: json["Qty"],
        price: json["Price"],
        discRatio: json["DiscRatio"],
        discValue: json["DiscValue"],
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "Qty": qty,
        "Price": price,
        "DiscRatio": discRatio,
        "DiscValue": discValue,
    };
}
