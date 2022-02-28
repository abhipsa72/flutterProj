import 'package:flutter/material.dart';
import 'package:grand_uae/customer/product/product_item.dart';
import 'package:grand_uae/customer/wishlist/wishlist_model.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
      ),
      body: Consumer<WishListModel>(
        builder: (_, model, child) {
          if (model.products == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.products.isEmpty) {
            return Center(
              child: Text("No items"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            itemCount: model.products.length,
            itemBuilder: (_, index) {
              var product = model.products[index];
              return ProductItem(product);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
            ),
          );
        },
      ),
    );
  }
}
