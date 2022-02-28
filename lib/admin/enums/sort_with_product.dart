enum SortWithProduct {
  ProductName,
  ProductNameDesc,
  Model,
  ModelDesc,
  Price,
  PriceDesc,
  Quantity,
  QuantityDesc,
  Status,
  StatusDesc,
  Default
}

String getNameOfSort(SortWithProduct sortWithProduct) {
  switch (sortWithProduct) {
    case SortWithProduct.ProductName:
      return "Product name";
    case SortWithProduct.Model:
      return "Model";
    case SortWithProduct.Price:
      return "Price";
    case SortWithProduct.Quantity:
      return "Quantity";
    case SortWithProduct.Status:
      return "Status";
    case SortWithProduct.ProductNameDesc:
      return "Product name(Desc)";
    case SortWithProduct.ModelDesc:
      return "Model(Desc)";
    case SortWithProduct.PriceDesc:
      return "Price(Desc)";
    case SortWithProduct.QuantityDesc:
      return "Quantity(Desc)";
    case SortWithProduct.StatusDesc:
      return "Status(Desc)";
    case SortWithProduct.Default:
      return "Select Sort";
  }
  return "N/A";
}
