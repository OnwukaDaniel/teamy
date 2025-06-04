class ValidatorService {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.split(' ').length < 2) {
      return 'Enter your first name and last name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if ((int.tryParse(value) ?? -1) == -1) {
      return 'Enter a valid Phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (value.length < 6) {
      return 'Confirm Password must be at least 6 characters';
    }
    if (value != password) {
      return "Passwords don't match";
    }
    return null;
  }
}