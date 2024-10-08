part of "../components.dart";

List<String> validationErrors = [];
String? validator(String? value, String type) {
  String? error;
  switch (type) {
    case "link":
      return null;
    case "email":
      error = validateEmail(value);
      break;
    case "password":
      error = validatePassword(value);
      break;
    case "confirm_password":
      error = validatePassword(value, confirm: true);
      break;
    case "phone" || "phone_number" || "mpesa_number":
      error = validatePhone(value);
      break;
    case "id_number":
      error = validateIdNumber(value);
      break;
    case "name":
      error = validName(value);
      break;
    case "date":
      error = validateDate(value);
      break;
    case "money":
      error = validateMoney(value);
      break;
    case "number":
      error = validateNumber(value);
      break;
    case "address":
      error = value!.length < 4 ? "Enter a valid place name" : null;
      break;
    case "item_name":
      error = value!.length < 4 ? "Enter a valid item name" : null;
      break;
    case "license":
      break;
    case "description":
      error = value!.isEmpty ? "Enter something" : null;
      break;
    case "vehicle":
      break;
    default:
      return 'Invalid type';
  }
  if (error != null) {
    addError(error);
  }
  validationErrors = validationErrors.toSet().toList();
  return error;
}

// validate number
String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a valid dimension";
  }
  return null;
}

// validate money
String? validateMoney(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a valid Amount";
  }

  return null;
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return "Date of birth is required";
  }
  final components = value.split("/");
  if (components.length == 3) {
    final day = int.tryParse(components[0]);
    final month = int.tryParse(components[1]);
    final year = int.tryParse(components[2]);
    if (day != null && month != null && year != null) {
      final date = DateTime(year, month, day);
      if (date.year == year && date.month == month && date.day == day) {
        return null;
      }
    }
  }
  return "Invalid date of birth";
}

void addError(val) {
  if (val != null) {
    validationErrors.add(val);
  }
}

String? validName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return 'Invalid name format';
  }
  return null;
}

String? validatePassword(String? value, {bool confirm = false}) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  if (confirm && value != activeUser.value.password) {
    return "Passwords provide do not match";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
      .hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }

  String phone = value.replaceAll(" ", "");

  if (!RegExp(r'^\d+$').hasMatch(phone)) {
    return 'Phone number can only contain digits';
  }

  if (phone.startsWith('0')) {
    if (phone.length != 10) {
      return 'Phone number must be 10 digits long';
    }
    if (!(phone[1] == '1' || phone[1] == '7')) {
      return 'Phone number must start with 01 or 07';
    }
    if (!RegExp(r'^0+').hasMatch(phone)) {
      return 'Phone number cannot be all zeros';
    }
  } else {
    if (phone.length != 9) {
      return 'Phone number must be 9 digits long without leading 0';
    }
  }

  return null;
}

// validate ID/Passport number
String? validateIdNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'ID/Passport number is required';
  }

  if (value.length < 8) {
    return 'Invalid ID/Passport number';
  }

  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Invalid ID/Passport number';
  }

  return null;
}

// keyboard
TextInputType getTextInputType(String type) {
  switch (type) {
    case "number" || "id_number" || "money":
      return TextInputType.number;
    case "email":
      return TextInputType.emailAddress;
    case "date":
      return TextInputType.datetime;
    case "phone" || "phone_number" || "mpesa_number":
      return TextInputType.phone;
    default:
      return TextInputType.text;
  }
}

List<TextInputFormatter> inputFormatters(String type) {
  switch (type) {
    case "phone" || "mpesa_number":
      return [
        MaskTextInputFormatter(
          mask: '### #### ###',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.lazy,
        )
      ];
    default:
      return [];
  }
}

// input capitalization
TextCapitalization getTextCapitalization(String type) {
  switch (type) {
    case "name":
      return TextCapitalization.words;
    default:
      return TextCapitalization.none;
  }
}
