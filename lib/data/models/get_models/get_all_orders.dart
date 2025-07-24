// To parse this JSON data, do
//
//     final getAllOrders = getAllOrdersFromJson(jsonString);

import 'dart:convert';

List<GetAllOrders> getAllOrdersFromJson(String str) => List<GetAllOrders>.from(json.decode(str).map((x) => GetAllOrders.fromJson(x)));

String getAllOrdersToJson(List<GetAllOrders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllOrders {
    final int? orderId;
    final DateTime? docDate;
    final String? docNbr;
    final String? status;
    final int? paymentModeId;
    final String? paymentMode;
    final double? amount;

    GetAllOrders({
        this.orderId,
        this.docDate,
        this.docNbr,
        this.status,
        this.paymentModeId,
        this.paymentMode,
        this.amount,
    });

    GetAllOrders copyWith({
        int? orderId,
        DateTime? docDate,
        String? docNbr,
        String? status,
        int? paymentModeId,
        String? paymentMode,
        double? amount,
    }) => 
        GetAllOrders(
            orderId: orderId ?? this.orderId,
            docDate: docDate ?? this.docDate,
            docNbr: docNbr ?? this.docNbr,
            status: status ?? this.status,
            paymentModeId: paymentModeId ?? this.paymentModeId,
            paymentMode: paymentMode ?? this.paymentMode,
            amount: amount ?? this.amount,
        );

    factory GetAllOrders.fromJson(Map<String, dynamic> json) => GetAllOrders(
        orderId: json["OrderId"],
        docDate: json["DocDate"] == null ? null : DateTime.parse(json["DocDate"]),
        docNbr: json["DocNbr"],
        status: json["Status"],
        paymentModeId: json["PaymentModeId"],
        paymentMode: json["PaymentMode"],
        amount: json["Amount"],
    );

    Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "DocDate": docDate?.toIso8601String(),
        "DocNbr": docNbr,
        "Status": status,
        "PaymentModeId": paymentModeId,
        "PaymentMode": paymentMode,
        "Amount": amount,
    };
}
