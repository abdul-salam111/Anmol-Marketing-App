// To parse this JSON data, do
//
//     final getRegistrationResponseModel = getRegistrationResponseModelFromJson(jsonString);

import 'dart:convert';

GetRegistrationResponseModel getRegistrationResponseModelFromJson(String str) => GetRegistrationResponseModel.fromJson(json.decode(str));

String getRegistrationResponseModelToJson(GetRegistrationResponseModel data) => json.encode(data.toJson());

class GetRegistrationResponseModel {
    final int customerId;
    final String otp;
    final String mobileNbr;
    final String customerName;
    final String password;
    final int locationId;
    final String licenseNbr;
    final String address;
    final DateTime licenseExpiryDate;

    GetRegistrationResponseModel({
        required this.customerId,
        required this.otp,
        required this.mobileNbr,
        required this.customerName,
        required this.password,
        required this.locationId,
        required this.licenseNbr,
        required this.address,
        required this.licenseExpiryDate,
    });

    GetRegistrationResponseModel copyWith({
        int? customerId,
        String? otp,
        String? mobileNbr,
        String? customerName,
        String? password,
        int? locationId,
        String? licenseNbr,
        String? address,
        DateTime? licenseExpiryDate,
    }) => 
        GetRegistrationResponseModel(
            customerId: customerId ?? this.customerId,
            otp: otp ?? this.otp,
            mobileNbr: mobileNbr ?? this.mobileNbr,
            customerName: customerName ?? this.customerName,
            password: password ?? this.password,
            locationId: locationId ?? this.locationId,
            licenseNbr: licenseNbr ?? this.licenseNbr,
            address: address ?? this.address,
            licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
        );

    factory GetRegistrationResponseModel.fromJson(Map<String, dynamic> json) => GetRegistrationResponseModel(
        customerId: json["CustomerId"],
        otp: json["OTP"],
        mobileNbr: json["MobileNbr"],
        customerName: json["CustomerName"],
        password: json["Password"],
        locationId: json["LocationId"],
        licenseNbr: json["LicenseNbr"],
        address: json["Address"],
        licenseExpiryDate: DateTime.parse(json["LicenseExpiryDate"]),
    );

    Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "OTP": otp,
        "MobileNbr": mobileNbr,
        "CustomerName": customerName,
        "Password": password,
        "LocationId": locationId,
        "LicenseNbr": licenseNbr,
        "Address": address,
        "LicenseExpiryDate": "${licenseExpiryDate.year.toString().padLeft(4, '0')}-${licenseExpiryDate.month.toString().padLeft(2, '0')}-${licenseExpiryDate.day.toString().padLeft(2, '0')}",
    };
}
