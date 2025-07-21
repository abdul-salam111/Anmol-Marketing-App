// To parse this JSON data, do
//
//     final getCompaniesModel = getCompaniesModelFromJson(jsonString);

import 'dart:convert';

List<GetCompaniesModel> getCompaniesModelFromJson(String str) => List<GetCompaniesModel>.from(json.decode(str).map((x) => GetCompaniesModel.fromJson(x)));

String getCompaniesModelToJson(List<GetCompaniesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCompaniesModel {
    final int? companyId;
    final String? companyName;
    final String? companyLogo;

    GetCompaniesModel({
        this.companyId,
        this.companyName,
        this.companyLogo,
    });

    GetCompaniesModel copyWith({
        int? companyId,
        String? companyName,
        String? companyLogo,
    }) => 
        GetCompaniesModel(
            companyId: companyId ?? this.companyId,
            companyName: companyName ?? this.companyName,
            companyLogo: companyLogo ?? this.companyLogo,
        );

    factory GetCompaniesModel.fromJson(Map<String, dynamic> json) => GetCompaniesModel(
        companyId: json["CompanyId"],
        companyName: json["CompanyName"],
        companyLogo: json["CompanyLogo"],
    );

    Map<String, dynamic> toJson() => {
        "CompanyId": companyId,
        "CompanyName": companyName,
        "CompanyLogo": companyLogo,
    };
}
