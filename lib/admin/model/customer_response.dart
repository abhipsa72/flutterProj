import 'dart:convert';

CustomerResponse customersFromMap(dynamic str) => CustomerResponse.fromMap(str);

String customerResponseToMap(CustomerResponse data) =>
    json.encode(data.toMap());

class CustomerResponse {
  CustomerResponse({
    this.success,
  });

  Success success;

  factory CustomerResponse.fromMap(Map<String, dynamic> json) =>
      CustomerResponse(
        success:
            json["success"] == null ? null : Success.fromMap(json["success"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success.toMap(),
      };
}

class Success {
  Success({
    this.customers,
  });

  List<Customer> customers;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        customers: json["customers"] == null
            ? null
            : List<Customer>.from(
                json["customers"].map((x) => Customer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "customers": customers == null
            ? null
            : List<dynamic>.from(customers.map((x) => x.toMap())),
      };
}

class Customer {
  Customer({
    this.customerId,
    this.customerGroupId,
    this.storeId,
    this.languageId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.fax,
    this.password,
    this.salt,
    this.cart,
    this.wishlist,
    this.newsletter,
    this.addressId,
    this.customField,
    this.ip,
    this.status,
    this.safe,
    this.token,
    this.code,
    this.dateAdded,
    this.name,
    this.description,
    this.customerGroup,
  });

  String customerId;
  String customerGroupId;
  String storeId;
  String languageId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String fax;
  String password;
  String salt;
  dynamic cart;
  dynamic wishlist;
  String newsletter;
  String addressId;
  CustomField customField;
  String ip;
  String status;
  String safe;
  String token;
  Code code;
  DateTime dateAdded;
  String name;
  Description description;
  CustomerGroupEnum customerGroup;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customerGroupId: json["customer_group_id"] == null
            ? null
            : json["customer_group_id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        fax: json["fax"] == null ? null : json["fax"],
        password: json["password"] == null ? null : json["password"],
        salt: json["salt"] == null ? null : json["salt"],
        cart: json["cart"],
        wishlist: json["wishlist"],
        newsletter: json["newsletter"] == null ? null : json["newsletter"],
        addressId: json["address_id"] == null ? null : json["address_id"],
        customField: json["custom_field"] == null
            ? null
            : customFieldValues.map[json["custom_field"]],
        ip: json["ip"] == null ? null : json["ip"],
        status: json["status"] == null ? null : json["status"],
        safe: json["safe"] == null ? null : json["safe"],
        token: json["token"] == null ? null : json["token"],
        code: json["code"] == null ? null : codeValues.map[json["code"]],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null
            ? null
            : descriptionValues.map[json["description"]],
        customerGroup: json["customer_group"] == null
            ? null
            : customerGroupValues.map[json["customer_group"]],
      );

  Map<String, dynamic> toMap() => {
        "customer_id": customerId == null ? null : customerId,
        "customer_group_id": customerGroupId == null ? null : customerGroupId,
        "store_id": storeId == null ? null : storeId,
        "language_id": languageId == null ? null : languageId,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "telephone": telephone == null ? null : telephone,
        "fax": fax == null ? null : fax,
        "password": password == null ? null : password,
        "salt": salt == null ? null : salt,
        "cart": cart,
        "wishlist": wishlist,
        "newsletter": newsletter == null ? null : newsletter,
        "address_id": addressId == null ? null : addressId,
        "custom_field":
            customField == null ? null : customFieldValues.reverse[customField],
        "ip": ip == null ? null : ip,
        "status": status == null ? null : status,
        "safe": safe == null ? null : safe,
        "token": token == null ? null : token,
        "code": code == null ? null : codeValues.reverse[code],
        "date_added": dateAdded == null ? null : dateAdded.toIso8601String(),
        "name": name == null ? null : name,
        "description":
            description == null ? null : descriptionValues.reverse[description],
        "customer_group": customerGroup == null
            ? null
            : customerGroupValues.reverse[customerGroup],
      };
}

enum Code { EMPTY, PPYP_R_GOM_A4_A_J_TM7_SI_VAMQ_MD_HS5_EXIL9_QDT_PBIQ_RL }

final codeValues = EnumValues({
  "": Code.EMPTY,
  "ppypRGomA4aJTm7SIVamqMdHs5EXIL9qdtPBIQRl":
      Code.PPYP_R_GOM_A4_A_J_TM7_SI_VAMQ_MD_HS5_EXIL9_QDT_PBIQ_RL
});

enum CustomField { EMPTY, CUSTOM_FIELD }

final customFieldValues =
    EnumValues({"[]": CustomField.CUSTOM_FIELD, "": CustomField.EMPTY});

enum CustomerGroupEnum { DEFAULT }

final customerGroupValues = EnumValues({"Default": CustomerGroupEnum.DEFAULT});

enum Description { TEST }

final descriptionValues = EnumValues({"test": Description.TEST});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
