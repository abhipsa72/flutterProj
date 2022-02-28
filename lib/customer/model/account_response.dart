// To parse this JSON data, do
//
//     final accountDetailsResponse = accountDetailsResponseFromMap(jsonString);

import 'package:grand_uae/customer/model/order.dart';

AccountDetailsResponse accountDetailsFromMap(dynamic str) =>
    AccountDetailsResponse.fromMap(str);

class AccountDetailsResponse {
  AccountDetailsResponse({
    this.personalDetail,
    this.addressBook,
    this.wishlist,
    this.orderHistory,
    this.rewardPoints,
    this.returns,
    this.transaction,
    this.newsletter,
  });

  PersonalDetail personalDetail;
  List<AddressBook> addressBook;
  List<WishList> wishlist;
  List<Order> orderHistory;
  dynamic rewardPoints;
  dynamic returns;
  dynamic transaction;
  Newsletter newsletter;

  factory AccountDetailsResponse.fromMap(Map<String, dynamic> json) =>
      AccountDetailsResponse(
        personalDetail: json["personal_detail"] == null
            ? null
            : PersonalDetail.fromMap(json["personal_detail"]),
        addressBook: json["address_book"] == null
            ? []
            : List<AddressBook>.from(
                json["address_book"].map(
                  (x) => AddressBook.fromMap(x),
                ),
              ),
        wishlist: json["wishlist"] == null
            ? []
            : List<WishList>.from(
                json["wishlist"].map(
                  (x) => WishList.fromMap(x),
                ),
              ),
        orderHistory: json["order_history"] == null
            ? null
            : List<Order>.from(
                json["order_history"].map(
                  (x) => Order.fromMap(x),
                ),
              ),
        rewardPoints: json["reward_points"],
        returns: json["returns"],
        transaction: json["transaction"],
        newsletter: json["newsletter"] == null
            ? null
            : Newsletter.fromMap(json["newsletter"]),
      );
}

class AddressBook {
  AddressBook({
    this.addressId,
    this.firstname,
    this.lastname,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.countryId,
    this.country,
    this.zoneId,
    this.zone,
  });

  String addressId;
  String firstname;
  String lastname;
  String company = "Zedeye";
  String address1;
  String address2;
  String city;
  String postcode;
  String countryId;
  String country;
  String zoneId;
  String zone;
  int useDefault = 0;

  String fullName() => '$firstname $lastname';

  String address() {
    return '$address1, $address1,\n$zone,\n$city,\n$country\n$postcode';
  }

  String addressString() {
    return '$firstname $lastname, $address1, $address2, $zone, $city, $country $postcode';
  }

  String fullAddress() {
    return '$firstname $lastname\n$address1, $address1,\n$zone,\n$city,\n$country\n$postcode';
  }

  factory AddressBook.fromMap(Map<String, dynamic> json) => AddressBook(
        addressId: json["address_id"] == null ? null : json["address_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        company: json["company"] == null ? null : json["company"],
        address1: json["address_1"] == null ? null : json["address_1"],
        address2: json["address_2"] == null ? null : json["address_2"],
        city: json["city"] == null ? null : json["city"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        country: json["country"] == null ? null : json["country"],
        zoneId: json["zone_id"] == null ? null : json["zone_id"],
        zone: json["zone"] == null ? null : json["zone"],
      );

  Map<String, dynamic> toMap() => {
        "address_id": addressId == null ? null : addressId,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "company": company == null ? null : company,
        "address_1": address1 == null ? null : address1,
        "address_2": address2 == null ? null : address2,
        "city": city == null ? null : city,
        "postcode": postcode == null ? null : postcode,
        "country_id": countryId == null ? null : countryId,
        "country": country == null ? null : country,
        "zone_id": zoneId == null ? null : zoneId,
        "zone": zone == null ? null : zone,
        "default": useDefault == null ? 0 : useDefault,
      };
}

class Newsletter {
  Newsletter({
    this.newsletter,
  });

  String newsletter;

  factory Newsletter.fromMap(Map<String, dynamic> json) => Newsletter(
        newsletter: json["newsletter"] == null ? null : json["newsletter"],
      );
}

class WishList {
  WishList({
    this.customerId,
    this.productId,
    this.dateAdded,
  });

  String customerId;
  String productId;
  DateTime dateAdded;

  factory WishList.fromMap(Map<String, dynamic> json) => WishList(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );
}

class PersonalDetail {
  PersonalDetail({
    this.customerId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.defaultAddressId,
  });

  String customerId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  String defaultAddressId;

  factory PersonalDetail.fromMap(Map<String, dynamic> json) => PersonalDetail(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        defaultAddressId: json['default_address_id'] == null
            ? null
            : json['default_address_id'],
      );

  Map<String, dynamic> toMap() => {
        "customer_id": customerId == null ? null : customerId,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "telephone": telephone == null ? null : telephone,
        "default_address_id":
            defaultAddressId == null ? null : defaultAddressId,
      };

  @override
  String toString() {
    return "$firstname $lastname\n$email\n$telephone";
  }

  String fullName() => '$firstname $lastname';
}
