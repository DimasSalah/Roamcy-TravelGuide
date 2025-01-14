import 'package:get/get_utils/src/get_utils/get_utils.dart';

class FormValidation {
  static String? validatePassword6Char(String? passwordValue) {
    if (passwordValue == null) {
      return "Password is required";
    }
    if (passwordValue.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? validatePasswordMatch(String? passwordValue, String? confirmPasswordValue) {
    if (passwordValue == confirmPasswordValue) {
      return null;
    } else {
      return "Passwords don't match";
    }
  }

  static String? validateEmail(String? emailValue) {
    if (emailValue == null) {
      return "Email is required";
    }
    if (!GetUtils.isEmail(emailValue)) {
      return "Invalid email address";
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }
}
