// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) =>
    RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) =>
    json.encode(data.toJson());

class RegisterUserModel {
  final String customerName;
  final String mobileNbr;
  final String password;
  final int locationId;
  final String licenseNbr;

  final String? owerName;
  final String? address;
  final String? phoneWork;
  final String? licenseExpiryDate;

  RegisterUserModel({
    required this.customerName,
    required this.mobileNbr,
    required this.password,
    required this.locationId,
    required this.licenseNbr,

    this.owerName,
    this.address,
    this.phoneWork,
    this.licenseExpiryDate,
  });

  RegisterUserModel copyWith({
    String? customerName,
    String? mobileNbr,
    String? password,
    int? locationId,
    String? licenseNbr,
    String? owerName,
    String? address,
    String? phoneWork,
    String? licenseExpiryDate,
  }) => RegisterUserModel(
    customerName: customerName ?? this.customerName,
    mobileNbr: mobileNbr ?? this.mobileNbr,
    password: password ?? this.password,
    locationId: locationId ?? this.locationId,
    licenseNbr: licenseNbr ?? this.licenseNbr,

    owerName: owerName ?? this.owerName,
    address: address ?? this.address,
    phoneWork: phoneWork ?? this.phoneWork,
    licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
  );

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserModel(
        customerName: json["CustomerName"],
        mobileNbr: json["MobileNbr"],
        password: json["Password"],
        locationId: json["LocationId"],
        licenseNbr: json["LicenseNbr"],

        owerName: json["OwerName"],
        address: json["Address"],
        phoneWork: json["PhoneWork"],
        licenseExpiryDate: json["LicenseExpiryDate"],
      );

  Map<String, dynamic> toJson() => {
    "CustomerName": customerName,
    "MobileNbr": mobileNbr,
    "Password": password,
    "LocationId": locationId,
    "LicenseNbr": licenseNbr,

    "OwerName": owerName,
    "Address": address,
    "PhoneWork": phoneWork,
    "LicenseExpiryDate": licenseExpiryDate,
  };
}
