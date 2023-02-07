import '../extensions/string_extension.dart';

mixin Validators {
  String? validateEmail(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (email != null && regExp.hasMatch(email)) {
      return null;
    } else {
      const String errorText = 'Please enter a valid email';
      return errorText;
    }
  }

  String? validateLengthGt6(String? text) {
    final textLength = text?.length;
    if (!text.nullOrEmpty && textLength! > 6) {
      return null;
    } else {
      const errMessage = 'Input must be more than 6 char';
      return errMessage;
    }
  }

  String? validateTextOnly(String? text) {
    // [^a-z şçğüıö,;:/*-._=]
    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    if (text != null && !regExp.hasMatch(text)) {
      return null;
    }
    if (text.nullOrEmpty) {
      const String errorText = 'This field is required';
      return errorText;
    } else {
      const String errorText = 'Field can contain letters only';
      return errorText;
    }
  }

  String? validateNumbersOnly(String? text) {
    // [^a-z şçğüıö,;:/*-._=]
    //String pattern = r'^[a-z]*$/-._=\-=@,\.;&%#';
    String pattern = r'^[0-9]*$';
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    if (!text.nullOrEmpty && regExp.hasMatch(text!)) {
      return null;
    }
    if (text.nullOrEmpty) {
      const String errorText = 'This field is required';
      return errorText;
    } else {
      const String errorText = 'Field can contain numbers only';
      return errorText;
    }
  }

  String? validateNumbersOnlyGt2(String? text) {
    // [^a-z şçğüıö,;:/*-._=]
    //String pattern = r'^[a-z]*$/-._=\-=@,\.;&%#';
    String pattern = r'^[0-9]*$';
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    if (!text.nullOrEmpty && regExp.hasMatch(text!) && text.length > 2) {
      return null;
    }
    if (text.nullOrEmpty) {
      const String errorText = 'This field is required';
      return errorText;
    } else {
      const String errorText = 'Field can contain numbers only';
      return errorText;
    }
  }

  String? validateIsEmpty(String? text) {
    if (text != null && text.isNotEmpty) return null;
    const errText = 'This Field is requried';
    return errText;
  }

  String? validateGenericIsEmpty<T>(T? type) {
    if (type != null) return null;
    const errText = 'This Field is requried';
    return errText;
  }

  bool validateTextOnlyBool(String text) {
    String pattern = r'[^a-z şçğüıö]';
    RegExp regExp = RegExp(pattern, caseSensitive: false);

    return regExp.hasMatch(text);
  }

  bool validateLengthBool(String text, int length) {
    final res = text.length > length;
    return res;
  }

  bool validateEmailBool(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(email);
  }

  bool validateIsEmptyBool(String text) {
    return text.isEmpty;
  }

  validateFullName(text) {
    if (validateTextOnlyBool(text!)) {
      return 'Full name can contain only letters only';
    }
    if (validateLengthBool(text, 20)) {
      return 'Full name can be 20 character max';
    }
    if (validateIsEmptyBool(text)) return 'Full name cant be empty';
    return null;
  }
}
