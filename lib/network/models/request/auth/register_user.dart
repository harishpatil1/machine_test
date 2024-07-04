class RegistrationRequest {
  String firstName;
  String lastName;
  String countryCode;
  String phoneNo;
  String email;
  String password;
  String confirmPassword;

  RegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phoneNo,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'country_code': countryCode,
      'phone_no': phoneNo,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }
}
