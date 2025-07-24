// To parse this JSON data, do
//
//     final getLastOrderModel = getLastOrderModelFromJson(jsonString);

import 'dart:convert';

GetLastOrderModel getLastOrderModelFromJson(String str) => GetLastOrderModel.fromJson(json.decode(str));

String getLastOrderModelToJson(GetLastOrderModel data) => json.encode(data.toJson());

class GetLastOrderModel {
    final int? orderId;
    final DateTime? docDate;
    final String? docNbr;
    final String? status;
    final int? paymentModeId;
    final String? paymentMode;
    final double? amount;

    GetLastOrderModel({
        this.orderId,
        this.docDate,
        this.docNbr,
        this.status,
        this.paymentModeId,
        this.paymentMode,
        this.amount,
    });

    GetLastOrderModel copyWith({
        int? orderId,
        DateTime? docDate,
        String? docNbr,
        String? status,
        int? paymentModeId,
        String? paymentMode,
        double? amount,
    }) => 
        GetLastOrderModel(
            orderId: orderId ?? this.orderId,
            docDate: docDate ?? this.docDate,
            docNbr: docNbr ?? this.docNbr,
            status: status ?? this.status,
            paymentModeId: paymentModeId ?? this.paymentModeId,
            paymentMode: paymentMode ?? this.paymentMode,
            amount: amount ?? this.amount,
        );

    factory GetLastOrderModel.fromJson(Map<String, dynamic> json) => GetLastOrderModel(
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
