// To parse this JSON data, do
//
//     final profileUpdateResponse = profileUpdateResponseFromJson(jsonString);

import 'dart:convert';

ProfileUpdateResponse profileUpdateResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return ProfileUpdateResponse.fromJson(jsonData);
}

String profileUpdateResponseToJson(ProfileUpdateResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ProfileUpdateResponse {
  bool? status;
  String? message;
  String ? record;

  ProfileUpdateResponse({
    this.status,
    this.message,
    this.record,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) => new ProfileUpdateResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    record: json["record"] == null ? null : json["record"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "record": record == null ? null : record,
  };
}
