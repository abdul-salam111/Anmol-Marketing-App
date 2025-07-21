// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) => LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
    final String loginId;
    final String password;

    LoginUserModel({
        required this.loginId,
       required this.password,
    });

    LoginUserModel copyWith({
        String? loginId,
        String? password,
    }) => 
        LoginUserModel(
            loginId: loginId ?? this.loginId,
            password: password ?? this.password,
        );

    factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        loginId: json["loginId"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "loginId": loginId,
        "password": password,
    };
}
