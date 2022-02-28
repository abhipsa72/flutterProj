enum SortWithAdminOrder {
  OrderId,
  OrderIdDesc,
  Customer,
  CustomerDesc,
  Status,
  StatusDesc,
  Total,
  TotalDesc,
  DateAdded,
  DateAddedDesc,
  DateModified,
  DateModifiedDesc,
  Default,
}

String getNameOfSort(SortWithAdminOrder adminOrder) {
  switch (adminOrder) {
    case SortWithAdminOrder.OrderId:
      return "Order ID";
    case SortWithAdminOrder.OrderIdDesc:
      return "Order ID(Desc)";
    case SortWithAdminOrder.Customer:
      return "Customer";
    case SortWithAdminOrder.CustomerDesc:
      return "Customer(Desc)";
    case SortWithAdminOrder.Status:
      return "Status";
    case SortWithAdminOrder.StatusDesc:
      return "Status(Desc)";
    case SortWithAdminOrder.Total:
      return "Total";
    case SortWithAdminOrder.TotalDesc:
      return "Total(Desc)";
    case SortWithAdminOrder.DateAdded:
      return "Date added";
    case SortWithAdminOrder.DateAddedDesc:
      return "Date added(Desc)";
    case SortWithAdminOrder.DateModified:
      return "Date modified";
    case SortWithAdminOrder.DateModifiedDesc:
      return "Date modified(Desc)";
    case SortWithAdminOrder.Default:
      return "Select sort";
  }
  return "N/A";
}
