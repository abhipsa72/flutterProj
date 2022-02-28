enum SortWithOrder {
  Default,
  Name_A_Z,
  Name_Z_A,
  Price_High_Low,
  Price_Low_High,
  Rating_High_Low,
  Rating_Low_High,
  Model_A_Z,
  Model_Z_A,
}

String getNameOfSort(SortWithOrder sortWithOrder) {
  switch (sortWithOrder) {
    case SortWithOrder.Default:
      return 'Default';
    case SortWithOrder.Name_A_Z:
      return "Name(A - Z)";
    case SortWithOrder.Name_Z_A:
      return "Name(Z - A)";
    case SortWithOrder.Price_High_Low:
      return "Price(High > Low)";
    case SortWithOrder.Price_Low_High:
      return "Price(Low > High)";
    case SortWithOrder.Rating_High_Low:
      return "Rating(Highest)";
    case SortWithOrder.Rating_Low_High:
      return "Rating(Lowest)";
    case SortWithOrder.Model_A_Z:
      return "Model(A - Z)";
    case SortWithOrder.Model_Z_A:
      return "Model(Z- A)";
  }
  return 'Default';
}
