

// password validator
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter a password.';
  }
  if (password.length<8) {
    return 'Password must be at least 8 characters ';
  }
  return null;
}

//phonenumber
String? validateMobileNumber(String? number) {
  if (number == null || number.isEmpty) {
    return 'Please enter a mobile number.';
  }

  final regex = RegExp(r'^\d{10}$');

  if (!regex.hasMatch(number)) {
    return 'Invalid mobile number format.';
  }

  return null;
}


// Confirm password validator
String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Please confirm your password.';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match.';
  }
  return null;
}
