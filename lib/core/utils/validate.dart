bool validate(String? value, String formRegExp) {
  if (value != null) {
    RegExp nameRegex = RegExp(formRegExp);
    if (!nameRegex.hasMatch(value)) {
      return false;
    }
  }

  return true;
}
