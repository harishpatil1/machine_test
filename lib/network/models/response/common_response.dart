class CommonResponse {
  bool? success;
  String? message;
  final List<String> errorMessages = [];

  CommonResponse({
    this.success,
    this.message,
  });
  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    CommonResponse instance = CommonResponse(
      success: json["success"],
      message: json["message"],
    );

    try {
      if (json.containsKey("errors")) {
        json["errors"].forEach((field, messages) {
          instance.errorMessages.addAll(messages.cast<String>());
        });
      }
    } catch (e) {}

    if (instance.errorMessages.isEmpty) {
      instance.errorMessages.add(instance.message ?? "");
    }
    return instance;
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
