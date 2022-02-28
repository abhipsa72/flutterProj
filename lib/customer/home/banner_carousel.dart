import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/home/home_model.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:provider/provider.dart';

class BannerCarousalImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (model.banners.isEmpty) {
          return Container();
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 240.0,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlay: true,
            aspectRatio: 16 / 9,
          ),
          items: model.banners.map((banner) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: NetworkProductImage(
                imageUrl: banner.image,
                isBoxFitContain: false,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
