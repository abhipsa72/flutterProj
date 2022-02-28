class Order {
  Order({
    this.orderId,
    this.invoiceNo,
    this.invoicePrefix,
    this.storeId,
    this.storeName,
    this.storeUrl,
    this.customerId,
    this.firstname,
    this.lastname,
    this.email,
    this.telephone,
    this.customField,
    this.paymentFirstname,
    this.paymentLastname,
    this.paymentCompany,
    this.paymentAddress1,
    this.paymentAddress2,
    this.paymentPostcode,
    this.paymentCity,
    this.paymentZoneId,
    this.paymentZone,
    this.paymentZoneCode,
    this.paymentCountryId,
    this.paymentCountry,
    this.paymentIsoCode2,
    this.paymentIsoCode3,
    this.paymentAddressFormat,
    this.paymentCustomField,
    this.paymentMethod,
    this.paymentCode,
    this.shippingFirstname,
    this.shippingLastname,
    this.shippingCompany,
    this.shippingAddress1,
    this.shippingAddress2,
    this.shippingPostcode,
    this.shippingCity,
    this.shippingZoneId,
    this.shippingZone,
    this.shippingZoneCode,
    this.shippingCountryId,
    this.shippingCountry,
    this.shippingIsoCode2,
    this.shippingIsoCode3,
    this.shippingAddressFormat,
    this.shippingCustomField,
    this.shippingMethod,
    this.shippingCode,
    this.comment,
    this.total,
    this.orderStatusId,
    this.orderStatus,
    this.affiliateId,
    this.commission,
    this.languageId,
    this.languageCode,
    this.currencyId,
    this.currencyCode,
    this.currencyValue,
    this.ip,
    this.forwardedIp,
    this.userAgent,
    this.acceptLanguage,
    this.dateAdded,
    this.dateModified,
  });

  String orderId;
  String invoiceNo;
  String invoicePrefix;
  String storeId;
  String storeName;
  String storeUrl;
  String customerId;
  String firstname;
  String lastname;
  String email;
  String telephone;
  dynamic customField;
  String paymentFirstname;
  String paymentLastname;
  String paymentCompany;
  String paymentAddress1;
  String paymentAddress2;
  String paymentPostcode;
  String paymentCity;
  String paymentZoneId;
  String paymentZone;
  String paymentZoneCode;
  String paymentCountryId;
  String paymentCountry;
  String paymentIsoCode2;
  String paymentIsoCode3;
  String paymentAddressFormat;
  List<dynamic> paymentCustomField;
  String paymentMethod;
  String paymentCode;
  String shippingFirstname;
  String shippingLastname;
  String shippingCompany;
  String shippingAddress1;
  String shippingAddress2;
  String shippingPostcode;
  String shippingCity;
  String shippingZoneId;
  String shippingZone;
  String shippingZoneCode;
  String shippingCountryId;
  String shippingCountry;
  String shippingIsoCode2;
  String shippingIsoCode3;
  String shippingAddressFormat;
  List<dynamic> shippingCustomField;
  String shippingMethod;
  String shippingCode;
  String comment;
  String total;
  String orderStatusId;
  dynamic orderStatus;
  String affiliateId;
  String commission;
  String languageId;
  String languageCode;
  String currencyId;
  String currencyCode;
  String currencyValue;
  String ip;
  String forwardedIp;
  String userAgent;
  String acceptLanguage;
  DateTime dateAdded;
  DateTime dateModified;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        orderId: json["order_id"] == null ? null : json["order_id"],
        invoiceNo: json["invoice_no"] == null ? null : json["invoice_no"],
        invoicePrefix:
            json["invoice_prefix"] == null ? null : json["invoice_prefix"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        storeName: json["store_name"] == null ? null : json["store_name"],
        storeUrl: json["store_url"] == null ? null : json["store_url"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        customField: json["custom_field"],
        paymentFirstname: json["payment_firstname"] == null
            ? null
            : json["payment_firstname"],
        paymentLastname:
            json["payment_lastname"] == null ? null : json["payment_lastname"],
        paymentCompany:
            json["payment_company"] == null ? null : json["payment_company"],
        paymentAddress1: json["payment_address_1"] == null
            ? null
            : json["payment_address_1"],
        paymentAddress2: json["payment_address_2"] == null
            ? null
            : json["payment_address_2"],
        paymentPostcode:
            json["payment_postcode"] == null ? null : json["payment_postcode"],
        paymentCity: json["payment_city"] == null ? null : json["payment_city"],
        paymentZoneId:
            json["payment_zone_id"] == null ? null : json["payment_zone_id"],
        paymentZone: json["payment_zone"] == null ? null : json["payment_zone"],
        paymentZoneCode: json["payment_zone_code"] == null
            ? null
            : json["payment_zone_code"],
        paymentCountryId: json["payment_country_id"] == null
            ? null
            : json["payment_country_id"],
        paymentCountry:
            json["payment_country"] == null ? null : json["payment_country"],
        paymentIsoCode2: json["payment_iso_code_2"] == null
            ? null
            : json["payment_iso_code_2"],
        paymentIsoCode3: json["payment_iso_code_3"] == null
            ? null
            : json["payment_iso_code_3"],
        paymentAddressFormat: json["payment_address_format"] == null
            ? null
            : json["payment_address_format"],
        paymentCustomField: json["payment_custom_field"] == null
            ? null
            : List<dynamic>.from(json["payment_custom_field"].map((x) => x)),
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        paymentCode: json["payment_code"] == null ? null : json["payment_code"],
        shippingFirstname: json["shipping_firstname"] == null
            ? null
            : json["shipping_firstname"],
        shippingLastname: json["shipping_lastname"] == null
            ? null
            : json["shipping_lastname"],
        shippingCompany:
            json["shipping_company"] == null ? null : json["shipping_company"],
        shippingAddress1: json["shipping_address_1"] == null
            ? null
            : json["shipping_address_1"],
        shippingAddress2: json["shipping_address_2"] == null
            ? null
            : json["shipping_address_2"],
        shippingPostcode: json["shipping_postcode"] == null
            ? null
            : json["shipping_postcode"],
        shippingCity:
            json["shipping_city"] == null ? null : json["shipping_city"],
        shippingZoneId:
            json["shipping_zone_id"] == null ? null : json["shipping_zone_id"],
        shippingZone:
            json["shipping_zone"] == null ? null : json["shipping_zone"],
        shippingZoneCode: json["shipping_zone_code"] == null
            ? null
            : json["shipping_zone_code"],
        shippingCountryId: json["shipping_country_id"] == null
            ? null
            : json["shipping_country_id"],
        shippingCountry:
            json["shipping_country"] == null ? null : json["shipping_country"],
        shippingIsoCode2: json["shipping_iso_code_2"] == null
            ? null
            : json["shipping_iso_code_2"],
        shippingIsoCode3: json["shipping_iso_code_3"] == null
            ? null
            : json["shipping_iso_code_3"],
        shippingAddressFormat: json["shipping_address_format"] == null
            ? null
            : json["shipping_address_format"],
        shippingCustomField: json["shipping_custom_field"] == null
            ? null
            : List<dynamic>.from(json["shipping_custom_field"].map((x) => x)),
        shippingMethod:
            json["shipping_method"] == null ? null : json["shipping_method"],
        shippingCode:
            json["shipping_code"] == null ? null : json["shipping_code"],
        comment: json["comment"] == null ? null : json["comment"],
        total: json["total"] == null ? null : json["total"],
        orderStatusId:
            json["order_status_id"] == null ? null : json["order_status_id"],
        orderStatus: json["order_status"],
        affiliateId: json["affiliate_id"] == null ? null : json["affiliate_id"],
        commission: json["commission"] == null ? null : json["commission"],
        languageId: json["language_id"] == null ? null : json["language_id"],
        languageCode:
            json["language_code"] == null ? null : json["language_code"],
        currencyId: json["currency_id"] == null ? null : json["currency_id"],
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencyValue:
            json["currency_value"] == null ? null : json["currency_value"],
        ip: json["ip"] == null ? null : json["ip"],
        forwardedIp: json["forwarded_ip"] == null ? null : json["forwarded_ip"],
        userAgent: json["user_agent"] == null ? null : json["user_agent"],
        acceptLanguage:
            json["accept_language"] == null ? null : json["accept_language"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        dateModified: json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId == null ? "null" : orderId,
        "invoice_no": invoiceNo == null ? "null" : invoiceNo,
        "invoice_prefix": invoicePrefix == null ? "null" : invoicePrefix,
        "store_id": storeId == null ? "null" : storeId,
        "store_name": storeName == null ? "null" : storeName,
        "store_url": storeUrl == null ? "null" : storeUrl,
        "customer_id": customerId == null ? "null" : customerId,
        "firstname": firstname == null ? "null" : firstname,
        "lastname": lastname == null ? "null" : lastname,
        "email": email == null ? "null" : email,
        "telephone": telephone == null ? "null" : telephone,
        "custom_field": customField == null ? "null" : customField,
        "payment_firstname":
            paymentFirstname == null ? "null" : paymentFirstname,
        "payment_lastname": paymentLastname == null ? "null" : paymentLastname,
        "payment_company": paymentCompany == null ? "null" : paymentCompany,
        "payment_address_1": paymentAddress1 == null ? "null" : paymentAddress1,
        "payment_address_2": paymentAddress2 == null ? "null" : paymentAddress2,
        "payment_postcode": paymentPostcode == null ? "null" : paymentPostcode,
        "payment_city": paymentCity == null ? "null" : paymentCity,
        "payment_zone_id": paymentZoneId == null ? "null" : paymentZoneId,
        "payment_zone": paymentZone == null ? "null" : paymentZone,
        "payment_zone_code": paymentZoneCode == null ? "null" : paymentZoneCode,
        "payment_country_id":
            paymentCountryId == null ? "null" : paymentCountryId,
        "payment_country": paymentCountry == null ? "null" : paymentCountry,
        "payment_iso_code_2":
            paymentIsoCode2 == null ? "null" : paymentIsoCode2,
        "payment_iso_code_3":
            paymentIsoCode3 == null ? "null" : paymentIsoCode3,
        "payment_address_format":
            paymentAddressFormat == null ? "null" : paymentAddressFormat,
        "payment_custom_field": paymentCustomField == null
            ? null
            : List<dynamic>.from(paymentCustomField.map((x) => x)),
        "payment_method": paymentMethod == null ? "null" : paymentMethod,
        "payment_code": paymentCode == null ? "null" : paymentCode,
        "shipping_firstname":
            shippingFirstname == null ? "null" : shippingFirstname,
        "shipping_lastname":
            shippingLastname == null ? "null" : shippingLastname,
        "shipping_company": shippingCompany == null ? "null" : shippingCompany,
        "shipping_address_1":
            shippingAddress1 == null ? "null" : shippingAddress1,
        "shipping_address_2":
            shippingAddress2 == null ? "null" : shippingAddress2,
        "shipping_postcode":
            shippingPostcode == null ? "null" : shippingPostcode,
        "shipping_city": shippingCity == null ? "null" : shippingCity,
        "shipping_zone_id": shippingZoneId == null ? "null" : shippingZoneId,
        "shipping_zone": shippingZone == null ? "null" : shippingZone,
        "shipping_zone_code":
            shippingZoneCode == null ? "null" : shippingZoneCode,
        "shipping_country_id":
            shippingCountryId == null ? "null" : shippingCountryId,
        "shipping_country": shippingCountry == null ? "null" : shippingCountry,
        "shipping_iso_code_2":
            shippingIsoCode2 == null ? "null" : shippingIsoCode2,
        "shipping_iso_code_3":
            shippingIsoCode3 == null ? "null" : shippingIsoCode3,
        "shipping_address_format":
            shippingAddressFormat == null ? "null" : shippingAddressFormat,
        "shipping_custom_field": shippingCustomField == null
            ? null
            : List<dynamic>.from(shippingCustomField.map((x) => x)),
        "shipping_method": shippingMethod == null ? "null" : shippingMethod,
        "shipping_code": shippingCode == null ? "null" : shippingCode,
        "comment": comment == null ? "null" : comment,
        "total": total == null ? "null" : total,
        "order_status_id": orderStatusId == null ? "null" : orderStatusId,
        "order_status": orderStatus,
        "affiliate_id": affiliateId == null ? "null" : affiliateId,
        "commission": commission == null ? "null" : commission,
        "language_id": languageId == null ? "null" : languageId,
        "language_code": languageCode == null ? "null" : languageCode,
        "currency_id": currencyId == null ? "null" : currencyId,
        "currency_code": currencyCode == null ? "null" : currencyCode,
        "currency_value": currencyValue == null ? "null" : currencyValue,
        "ip": ip == null ? "null" : ip,
        "forwarded_ip": forwardedIp == null ? "null" : forwardedIp,
        "user_agent": userAgent == null ? "null" : userAgent,
        "accept_language": acceptLanguage == null ? "null" : acceptLanguage,
        "date_added": dateAdded == null ? "null" : dateAdded.toIso8601String(),
        "date_modified":
            dateModified == null ? "null" : dateModified.toIso8601String(),
      };

  String get fullName => "$firstname $lastname";

  String get fullAddress {
    if (shippingAddress2.isEmpty) {
      return "$shippingAddress1, $shippingCity, $shippingZone, $shippingCity, $shippingCountry, $shippingPostcode";
    } else {
      return "$shippingAddress1, $shippingAddress2, $shippingCity, $shippingZone, $shippingCity, $shippingCountry, $shippingPostcode";
    }
  }
}
