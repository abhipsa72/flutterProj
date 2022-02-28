import 'dart:convert';

StoreModel storeModelFromJson(dynamic str) => StoreModel.fromMap(str);

String storeModelToJson(StoreModel data) => json.encode(data.toMap());

class StoreModel {
  StoreModel({
    this.stores,
  });

  final List<Store> stores;

  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
        stores: json["stores"] == null
            ? null
            : List<Store>.from(json["stores"].map((x) => Store.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "stores": stores == null
            ? null
            : List<dynamic>.from(stores.map((x) => x.toMap())),
      };
}

class Store {
  Store({
    this.budget,
    this.sales,
    this.variation,
    this.losses,
    this.lossesPercentage,
    this.variationPercentage,
    this.storeId,
    this.store,
  });

  final int budget;
  final int sales;
  final int variation;
  final int losses;
  final int lossesPercentage;
  final int variationPercentage;
  final int storeId;
  final String store;

  factory Store.fromMap(Map<String, dynamic> json) => Store(
        budget: json["budget"] == null ? null : json["budget"],
        sales: json["sales"] == null ? null : json["sales"],
        variation: json["variation"] == null ? null : json["variation"],
        losses: json["losses"] == null ? null : json["losses"],
        lossesPercentage: json["losses_percentage"] == null
            ? null
            : json["losses_percentage"],
        variationPercentage: json["variation_percentage"] == null
            ? null
            : json["variation_percentage"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        store: json["store"] == null ? null : json["store"],
      );

  Map<String, dynamic> toMap() => {
        "budget": budget == null ? null : budget,
        "sales": sales == null ? null : sales,
        "variation": variation == null ? null : variation,
        "losses": losses == null ? null : losses,
        "losses_percentage": lossesPercentage == null ? null : lossesPercentage,
        "variation_percentage":
            variationPercentage == null ? null : variationPercentage,
        "store_id": storeId == null ? null : storeId,
        "store": store == null ? null : store,
      };
}
