class FormValidationService {
  static String checkEmpty(String value) {
    if (value.length == 0) {
      return "This field can't be empty";
    }
    return null;
  }

  static bool validateName(String value) {
    if (value.length < 5) {
      return true;
    }

    return false;
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return true;
    else
      return false;
  }

  static String validatePhoneNumber(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Field must not be empty';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static bool validatePassword(String value) {
    if (value.length < 6) {
      return true;
    }

    return false;
  }

  static String confirmPasswordValidation(
      String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "Password doesn't match";
    }

    return null;
  }
}
