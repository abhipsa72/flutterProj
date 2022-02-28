class FilterOrders {
  String orderStatusId;
  String customer;
  String amount;
  int page;
  String dateAdded;
  String dateModified;

  FilterOrders({
    this.orderStatusId,
    this.customer,
    this.amount,
    this.page,
    this.dateAdded,
    this.dateModified,
  });
}
