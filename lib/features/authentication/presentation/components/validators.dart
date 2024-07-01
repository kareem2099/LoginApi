String? validateRegistrationPassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a password";
  } else if (value.length < 8) {
    return "At least 8 characters";
  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Include a lowercase letter";
  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Include an uppercase letter";
  } else if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "Include a digit";
  } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    return "Include a special character";
  }
  return null;
}

String? validateConfirmPassword(String? value, String originalPassword) {
  if (value == null || value.isEmpty) {
    return "Please confirm your password";
  } else if (value != originalPassword) {
    return "Passwords do not match";
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a name";
  } else if (value.length < 3) {
    return "At least 3 characters";
  }
  return null;
}

String? validateLoginPassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a password";
  } else if (value.length < 8) {
    return "At least 8 characters";
  }
  return null;
}


String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter a phone number";
  } else if (value.length > 11) {
    return "Max 11 characters";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter an email";
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return "Enter a valid email";
  }
  return null;
}
