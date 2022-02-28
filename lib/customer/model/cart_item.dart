class LocalCartProduct {
  final String productId;
  int quantity;

  LocalCartProduct(this.productId, this.quantity);

  @override
  String toString() {
    return "$productId -> $quantity ";
  }
}
