// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

BannerResponse bannersFromJson(dynamic str) => BannerResponse.fromJson(str);

class BannerResponse {
  BannerResponse({
    this.success,
  });

  Success success;

  factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        success: json["success"] is List<dynamic>
            ? null
            : Success.fromMap(json["success"]),
      );
}

class Success {
  Success({
    this.banners,
  });

  List<Banner> banners;

  factory Success.fromMap(Map<String, dynamic> json) => Success(
        banners: json["banners"] == null
            ? null
            : List<Banner>.from(json["banners"].map((x) => Banner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "banners": banners == null
            ? null
            : List<dynamic>.from(banners.map((x) => x.toMap())),
      };
}

class Banner {
  Banner({
    this.ptsliderImageId,
    this.ptsliderId,
    this.link,
    this.type,
    this.sliderStore,
    this.image,
    this.secondaryImage,
  });

  String ptsliderImageId;
  String ptsliderId;
  String link;
  String type;
  String sliderStore;
  String image;
  dynamic secondaryImage;

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        ptsliderImageId: json["ptslider_image_id"] == null
            ? null
            : json["ptslider_image_id"],
        ptsliderId: json["ptslider_id"] == null ? null : json["ptslider_id"],
        link: json["link"] == null ? null : json["link"],
        type: json["type"] == null ? null : json["type"],
        sliderStore: json["slider_store"] == null ? null : json["slider_store"],
        image: json["image"] == null ? null : json["image"],
        secondaryImage: json["secondary_image"],
      );

  Map<String, dynamic> toMap() => {
        "ptslider_image_id": ptsliderImageId == null ? null : ptsliderImageId,
        "ptslider_id": ptsliderId == null ? null : ptsliderId,
        "link": link == null ? null : link,
        "type": type == null ? null : type,
        "slider_store": sliderStore == null ? null : sliderStore,
        "image": image == null ? null : image,
        "secondary_image": secondaryImage,
      };
}
