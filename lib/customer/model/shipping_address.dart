class ShippingAddress {
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String countryId;
  String zoneId;
  String postCode;
  bool isDefault = false;

  ShippingAddress({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.countryId,
    this.zoneId,
    this.postCode,
    this.isDefault,
  });
}
