class BasicDetails {
  String currencyCodeLeft;
  String currencyCodeRight;
  num minimumOrder;
  num priceDecimal = 2;
  String countryName;
  String countryCode;

  BasicDetails({
    this.currencyCodeLeft,
    this.currencyCodeRight,
    this.minimumOrder,
    this.priceDecimal,
    this.countryName,
    this.countryCode,
  });

  @override
  String toString() {
    return 'BasicDetails{currencyCodeLeft: $currencyCodeLeft, currencyCodeRight: $currencyCodeRight, minimumOrder: $minimumOrder, priceDecimal: $priceDecimal, countryName: $countryName}';
  }
}
