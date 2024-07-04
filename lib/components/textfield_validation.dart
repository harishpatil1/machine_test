class TextFieldValidation {
  TextFieldValidation._();

  static String? validation({
    String? value,
    String? message,
    bool isEmailValidator = false,
    bool isMeal = false,
    bool isPasswordValidator = false,
    bool isFacebookURLValidator = false,
    bool isInstagramURLValidator = false,
    bool isTiktokURLValidator = false,
    bool isTwitterURLValidator = false,
    bool isName = false,
  }) {
    if (value!.isEmpty) {
      return "$message it is required!";
    } else if (isEmailValidator == true) {
      if (value.isEmpty) {
        return "$message it is required!";
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter Valid $message';
      }
    } else if (isName == true) {
      if (value.isEmpty) {
        return "$message it is required!";
      } else if (value.length > 30) {
        return '$message can\'t have more than 30 characters ';
      }
    } else if (isPasswordValidator == true) {
      if (value.isEmpty) {
        return "$message it is required!";
      } else if (!RegExp(
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$")
          .hasMatch(value)) {
        if (value.length < 5) {
          return 'Password must have at least 5 characters';
        } else if (!value.contains(RegExp(r'[a-z]'))) {
          return 'Password should be at least one special character,\n upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[A-Z]'))) {
          return 'Password should be  at least one special character,\n upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password should be  at least one special character, upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
          return 'Password should be  at least one special character, upper case, lower case and number.';
        }
      }
    } else if (isPasswordValidator == true) {
      if (value.isEmpty) {
        return "$message it is required!";
      } else if (!RegExp(
              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$")
          .hasMatch(value)) {
        if (value.length < 5) {
          return 'Password must have at least 5 characters';
        } else if (!value.contains(RegExp(r'[a-z]'))) {
          return 'Password should be at least one special character, upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[A-Z]'))) {
          return 'Password should be  at least one special character, upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password should be  at least one special character, upper case, lower case and number.';
        } else if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
          return 'Password should be  at least one special character, upper case, lower case and number.';
        }
      }
    } else if (isFacebookURLValidator == true) {
      if (!RegExp(
              r"(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?")
          .hasMatch(value)) {
        return "Enter valid facebook profile or page URL";
      }
    } else if (isInstagramURLValidator == true) {
      if (!RegExp(
              r"(?:(?:http|https):\/\/)?(?:www.)?instagram.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?")
          .hasMatch(value)) {
        return "Enter valid instagram profile or page link";
      }
    } else if (isTwitterURLValidator == true) {
      if (!RegExp(
              r"(?:http:\/\/)?(?:www\.)?twitter\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-]*)")
          .hasMatch(value)) {
        return "Enter valid twitter profile or page link";
      }
    }

    return null;
  }
}
