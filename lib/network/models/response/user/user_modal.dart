// user.dart
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String countryCode;
  final String phoneNo;
  final String status;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNo,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    countryCode: json['country_code'],
    phoneNo: json['phone_no'],
    status: json['status'],
  );
}

// user_list_response.dart
class UserListResponse {
  final bool status;
  final String message;
  final List<User> userList;
  final int currentPage;
  final int lastPage;
  final int total;
  final int perPage;

  UserListResponse({
    required this.status,
    required this.message,
    required this.userList,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.perPage,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      UserListResponse(
        status: json['status'],
        message: json['message'],
        userList: List<User>.from(
            json['userList'].map((userJson) => User.fromJson(userJson))),
        currentPage: json['currentPage'],
        lastPage: json['lastPage'],
        total: json['total'],
        perPage: json['perPage'],
      );
}
