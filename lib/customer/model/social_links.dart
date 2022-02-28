SocialLinks socialLinksFromMap(dynamic str) => SocialLinks.fromMap(str);

class SocialLinks {
  SocialLinks({
    this.uae,
    this.kuwait,
    this.oman,
    this.qatar,
  });

  Social uae;
  Social kuwait;
  Social oman;
  Social qatar;

  factory SocialLinks.fromMap(Map<String, dynamic> json) => SocialLinks(
        uae: json["uae"] == null ? null : Social.fromMap(json["uae"]),
        kuwait: json["kuwait"] == null ? null : Social.fromMap(json["kuwait"]),
        oman: json["oman"] == null ? null : Social.fromMap(json["oman"]),
        qatar: json["qatar"] == null ? null : Social.fromMap(json["qatar"]),
      );
}

class Social {
  Social({
    this.twitter,
    this.facebook,
    this.youtube,
    this.instagram,
    this.contactUs,
  });

  String twitter;
  String facebook;
  String youtube;
  String instagram;
  ContactUs contactUs;

  factory Social.fromMap(Map<String, dynamic> json) => Social(
        twitter: json["twitter"] == null ? null : json["twitter"],
        facebook: json["facebook"] == null ? null : json["facebook"],
        youtube: json["youtube"] == null ? null : json["youtube"],
        instagram: json["instagram"] == null ? null : json["instagram"],
        contactUs: json["contact_us"] == null
            ? null
            : ContactUs.fromMap(json["contact_us"]),
      );
}

class ContactUs {
  ContactUs({
    this.phone,
    this.fax,
    this.addressTitle,
    this.addressSummary,
    this.mapLink,
    this.email,
  });

  String phone;
  String fax;
  String addressTitle;
  String addressSummary;
  String mapLink;
  String email;

  factory ContactUs.fromMap(Map<String, dynamic> json) => ContactUs(
        phone: json["phone"] == null ? null : json["phone"],
        fax: json["fax"] == null ? null : json["fax"],
        addressTitle:
            json["address_title"] == null ? null : json["address_title"],
        addressSummary:
            json["address_summary"] == null ? null : json["address_summary"],
        mapLink: json["map_link"] == null ? null : json["map_link"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toMap() => {
        "phone": phone == null ? null : phone,
        "fax": fax == null ? null : fax,
        "address_title": addressTitle == null ? null : addressTitle,
        "address_summary": addressSummary == null ? null : addressSummary,
        "map_link": mapLink == null ? null : mapLink,
        "email": email == null ? null : email,
      };
}
