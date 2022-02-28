import 'dart:convert';

String addCustomerToMap(AddCustomer data) => json.encode(data.toMap());

class AddCustomer {
  AddCustomer({
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.password,
    this.confirm,
    this.agree,
    this.newsletter,
    this.customerGroupId,
  });

  String firstname;
  String lastname;
  String email;
  String telephone;
  String password;
  String confirm;
  int agree;
  int newsletter;
  int customerGroupId;

  factory AddCustomer.fromMap(Map<String, dynamic> json) => AddCustomer(
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        password: json["password"] == null ? null : json["password"],
        confirm: json["confirm"] == null ? null : json["confirm"],
        agree: json["agree"] == null ? null : json["agree"],
        newsletter: json["Newsletter"] == null ? null : json["Newsletter"],
        customerGroupId: json["customer_group_id"] == null
            ? null
            : json["customer_group_id"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "telephone": telephone == null ? null : telephone,
        "password": password == null ? null : password,
        "confirm": confirm == null ? null : confirm,
        "agree": agree == null ? null : agree,
        "Newsletter": newsletter == null ? null : newsletter,
        "customer_group_id": customerGroupId == null ? null : customerGroupId,
      };
}
