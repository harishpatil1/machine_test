import 'dart:convert';

class SignupInfluencerResponse {
  SignupInfluencerResponse({
    required this.success,
    required this.message,
  });

  late final bool success;
  late final String message;
  final List<String> errorMessages = [];

  SignupInfluencerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    try {
      if (json.containsKey("errors")) {
        json["errors"].forEach((field, messages) {
          errorMessages.addAll(messages.cast<String>());
        });
      }
    } catch (e) {}

    if (errorMessages.isEmpty) {
      errorMessages.add(message);
    }
  }
}
