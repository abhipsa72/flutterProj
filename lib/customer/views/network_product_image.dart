import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isBoxFitContain;

  NetworkProductImage({
    this.imageUrl,
    this.isBoxFitContain = true,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fadeInDuration: Duration(seconds: 1),
        fit: isBoxFitContain ? BoxFit.contain : BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("images/grand_logo.png"),
        ),
      );
    } catch (e) {
      return Icon(Icons.broken_image);
    }
  }
}
