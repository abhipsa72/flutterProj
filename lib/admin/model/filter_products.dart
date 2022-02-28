class FilterProducts {
  String name;
  String model;
  String price;
  String quantity;
  int status;
  int start;
  int limit;

  FilterProducts({
    this.name,
    this.model,
    this.price,
    this.quantity,
    this.status,
    this.start,
    this.limit,
  });

  Map<String, dynamic> toMap() => {
        "filter_name": name == null ? null : name,
        'filter_model': model == null ? null : model,
        'filter_price': price == null ? null : price,
        'filter_quantity': quantity == null ? null : quantity,
        'filter_status': status == null ? null : status,
        'page': start,
        'limit': limit,
      };
}
