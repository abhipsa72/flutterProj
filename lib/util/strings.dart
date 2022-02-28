import 'package:html_unescape/html_unescape.dart';

extension StringExtension on String {
  String firstLetterToUpperCase() {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  String capitalize() {
    try {
      return this.toLowerCase().split(' ').map((word) {
        String leftText =
            (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
    } catch (error) {
      return this;
    }
  }

  String toHtmlUnescapeCapitalize() {
    return HtmlUnescape().convert(this).capitalize();
  }

  String toUnderScore() {
    return HtmlUnescape().convert(this).replaceAll(" ", "_");
  }

  String toFirebaseTopicName() {
    return this.replaceAll(" ", "-").toLowerCase();
  }

  String toImageUrl(String countryCode, String imageFile) {
    return "https://www.grandhypermarkets.com/$countryCode/image/$imageFile";
  }
}

//https://www.grandhypermarkets.com/kuwait/image/cache/catalog/BANNER/bnnr3-825x482.jpg
String getImageFromProduct(String countryCode, String image) {
  return "https://www.grandhypermarkets.com/${countryCode ?? "grand_test"}/image/$image";
}

String categoryImageLink(String image) {
  return "https://grandhypermarkets.com/common_category_images/$image.jpg";
}
