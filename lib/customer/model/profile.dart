class Profile {
  String firstName;
  String lastName;
  String email;
  String phone;

  Profile(this.firstName, this.lastName, this.email, this.phone);

  @override
  String toString() {
    return "$firstName $lastName \n$phone \n$email";
  }
}
