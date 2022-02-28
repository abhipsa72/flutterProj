import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/customer/model/basic_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicDetailsService {
  Future<BasicDetails> getBasicDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final country = prefs.getString(selectedCountry);
    BasicDetails basicDetails = BasicDetails(
      currencyCodeLeft: prefs.getString("${country}_currencyCodeLeft"),
      currencyCodeRight: prefs.getString("${country}_currencyCodeRight"),
      countryCode: prefs.getString(selectedCountryCode),
      priceDecimal: prefs.getInt("${country}_priceDecimal"),
      minimumOrder: prefs.getInt("${country}_minimumOrder"),
      countryName: country,
    );
    return basicDetails;
  }
}
