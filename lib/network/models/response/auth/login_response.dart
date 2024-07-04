class LoginResponse {
  bool? status;
  String? message;
  UserRecord? record;

  LoginResponse({
    this.status,
    this.message,
    this.record,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      message: json["message"],
      record: json["record"] == null ? null : UserRecord.fromJson(json["record"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "record": record?.toJson(),
  };
}

class UserRecord {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? profileImg;
  String authToken;

  UserRecord({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.profileImg,
    required this.authToken,
  });

  factory UserRecord.fromJson(Map<String, dynamic> json) => UserRecord(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNo: json["phoneNo"],
    profileImg: json["profileImg"],
    authToken: json["authtoken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNo": phoneNo,
    "profileImg": profileImg,
    "authtoken": authToken,
  };
}
