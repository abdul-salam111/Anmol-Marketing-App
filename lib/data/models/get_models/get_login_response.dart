// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));

String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());

class GetLoginResponse {
    final Customer? customer;
    final AuthToken? authToken;

    GetLoginResponse({
        this.customer,
        this.authToken,
    });

    GetLoginResponse copyWith({
        Customer? customer,
        AuthToken? authToken,
    }) => 
        GetLoginResponse(
            customer: customer ?? this.customer,
            authToken: authToken ?? this.authToken,
        );

    factory GetLoginResponse.fromJson(Map<String, dynamic> json) => GetLoginResponse(
        customer: json["Customer"] == null ? null : Customer.fromJson(json["Customer"]),
        authToken: json["AuthToken"] == null ? null : AuthToken.fromJson(json["AuthToken"]),
    );

    Map<String, dynamic> toJson() => {
        "Customer": customer?.toJson(),
        "AuthToken": authToken?.toJson(),
    };
}

class AuthToken {
    final String? accessToken;
    final DateTime? expiration;
    final String? refreshToken;

    AuthToken({
        this.accessToken,
        this.expiration,
        this.refreshToken,
    });

    AuthToken copyWith({
        String? accessToken,
        DateTime? expiration,
        String? refreshToken,
    }) => 
        AuthToken(
            accessToken: accessToken ?? this.accessToken,
            expiration: expiration ?? this.expiration,
            refreshToken: refreshToken ?? this.refreshToken,
        );

    factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        accessToken: json["AccessToken"],
        expiration: json["Expiration"] == null ? null : DateTime.parse(json["Expiration"]),
        refreshToken: json["RefreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
        "Expiration": expiration?.toIso8601String(),
        "RefreshToken": refreshToken,
    };
}

class Customer {
    final int? customerId;
    final String? customerName;
    final int? locationId;
    final String? locationName;
    final double? balance;
    final String? logo;

    Customer({
        this.customerId,
        this.customerName,
        this.locationId,
        this.locationName,
        this.balance,
        this.logo,
    });

    Customer copyWith({
        int? customerId,
        String? customerName,
        int? locationId,
        String? locationName,
        double? balance,
        String? logo,
    }) => 
        Customer(
            customerId: customerId ?? this.customerId,
            customerName: customerName ?? this.customerName,
            locationId: locationId ?? this.locationId,
            locationName: locationName ?? this.locationName,
            balance: balance ?? this.balance,
            logo: logo ?? this.logo,
        );

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["CustomerId"],
        customerName: json["CustomerName"],
        locationId: json["LocationId"],
        locationName: json["LocationName"],
        balance: json["Balance"],
        logo: json["Logo"],
    );

    Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "CustomerName": customerName,
        "LocationId": locationId,
        "LocationName": locationName,
        "Balance": balance,
        "Logo": logo,
    };
}
