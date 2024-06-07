validInput(val, type) {
  if (val.isEmpty) {
    return "Enter required field";
  }
  if (type == "phoneNumber") {
    if (!val.startsWith("+639") &&
        !val.startsWith("09") &&
        !val.startsWith("(+63) 9")) {
      return "Invalid Phone Number";
    } else {
      if (val.startsWith("+639")) {
        if (val.length != 13) {
          return "Invalid Phone Number";
        } else {
          String lastTenDigits = val.substring(4);

          if (!lastTenDigits.contains(RegExp(r'[0-9]{9}'))) {
            return "Invalid Phone Number";
          }
        }
      } else if (val.startsWith("09")) {
        if (val.length != 11) {
          return "Invalid Phone Number";
        } else {
          String lastTenDigits = val.substring(2);
          if (!lastTenDigits.contains(RegExp(r'[0-9]{9}'))) {
            return "Invalid Phone Number";
          }
        }
      } else {
        if (val.length != 16) {
          return "Invalid Phone Number";
        } else {
          String lastTenDigits = val.substring(7);
          if (!lastTenDigits.contains(RegExp(r'[0-9]{9}'))) {
            return "Invalid Phone Number";
          }
        }
      }
    }
  }

  if (type == "phoneNumberAddress") {
    if (!val.startsWith("+639") && !val.startsWith("09")) {
      return "Invalid Phone Number";
    } else {
      if (val.startsWith("+639")) {
        if (val.length != 13) {
          return "Invalid Phone Number";
        } else {
          String lastTenDigits = val.substring(4);

          if (!lastTenDigits.contains(RegExp(r'[0-9]{9}'))) {
            return "Invalid Phone Number";
          }
        }
      } else if (val.startsWith("09")) {
        if (val.length != 11) {
          return "Invalid Phone Number";
        } else {
          String lastTenDigits = val.substring(2);
          if (!lastTenDigits.contains(RegExp(r'[0-9]{9}'))) {
            return "Invalid Phone Number";
          }
        }
      }
    }
  }

  if (type == "name") {
    if (!isValidName(val)) {
      return "Invalid Name. Name should not contain numbers";
    }
  }

  if (type == "password") {
    if (val.length < 8 || !containsUppercase(val) || !containsLowercase(val)) {
      return "Password must be at least 8 characters long, and contain one uppercase and one lowercase character.";
    }
  }

  if (type == 'postal_code') {
    if (val.length != 4) {
      return "Invalid postal code";
    }
  }

  if (type == 'shop_name') {
    if (val.endsWith(' ')) {
      return "last character should not end with whitespace character";
    } else if (val.length < 4) {
      return "${4 - val.length} More Characters required";
    }
  }

  if (type == 'product_name') {
    if (val.endsWith(' ')) {
      return "last character should not end with whitespace character";
    } else if (val.length < 4) {
      return "${4 - val.length} More Characters required";
    }
  }

  if (type == 'product_description') {
    if (val.length < 10) {
      return "${10 - val.length} More Characters required";
    }
  }
}

bool containsUppercase(String val) {
  return val.contains(RegExp(r'[A-Z]'));
}

bool containsLowercase(String val) {
  return val.contains(RegExp(r'[a-z]'));
}

bool isValidName(String name) {
  RegExp nameRegex = RegExp(r"^[A-Za-z.\- ]+$");
  return nameRegex.hasMatch(name);
}
