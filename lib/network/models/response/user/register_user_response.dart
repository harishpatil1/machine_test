// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserResponse registerUserResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return RegisterUserResponse.fromJson(jsonData);
}

String registerUserResponseToJson(RegisterUserResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class RegisterUserResponse {
  bool? status;
  String? message;
  Data? data;

  RegisterUserResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => new RegisterUserResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  int ?id;
  String? email;
  String ?token;

  Data({
    this.id,
    this.email,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "token": token == null ? null : token,
  };
}
