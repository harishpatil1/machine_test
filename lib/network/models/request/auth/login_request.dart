
import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  // String? userType;
  String? email;
  String? password;

  LoginRequest({
    // this.userType,
    this.email,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    // userType: json["user_type"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    // "user_type": userType,
    "email": email,
    "password": password,
  };
}
