import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/util/strings.dart';

class NetworkCategoryImage extends StatelessWidget {
  final String imageUrl;

  NetworkCategoryImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: categoryImageLink(imageUrl.toUnderScore()),
      fadeInDuration: Duration(seconds: 1),
      fit: BoxFit.contain,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("images/grand_logo.png"),
      ),
    );
  }
}
