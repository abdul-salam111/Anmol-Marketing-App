// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
    final String customerId;
    final String otp;

    VerifyOtpModel({
        required this.customerId,
        required this.otp,
    });

    VerifyOtpModel copyWith({
        String? customerId,
        String? otp,
    }) => 
        VerifyOtpModel(
            customerId: customerId ?? this.customerId,
            otp: otp ?? this.otp,
        );

    factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        customerId: json["CustomerId"],
        otp: json["Otp"],
    );

    Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "Otp": otp,
    };
}
