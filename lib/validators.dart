String validateName(String value) {
  if (value.length < 3)
    return 'Enter valid name';
  else
    return null;
}

String userNameValidator(String value) {
  if (value.length < 3)
    return 'Enter valid username';
  else
    return null;
}

String validateLastName(String value) {
  if (value.length < 1)
    return 'Enter valid name';
  else
    return null;
}

String validateMobile(String value) {
  if (value.length <= 7)
    return 'Mobile Number must be of 8 digit or more';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

String validatePassword(String value) {
  if (value.length <= 3) {
    return "Password should be more than 3 character";
  }
  return null;
}

String validateAddress(String value) {
  if (value.length < 4) {
    return "Address should be more than 4 character";
  }
  return null;
}

String validateCity(String value) {
  if (value.length < 3) {
    return "City should be more than 3 character";
  }
  return null;
}

String validateReview(String value) {
  if (value.length <= 3) {
    return "Review should be more than 3 character";
  }
  return null;
}

String postCodeValidation(String value) {
  if (value.length >= 5) {
    return null;
  } else {
    return "Check the post code";
  }
}
