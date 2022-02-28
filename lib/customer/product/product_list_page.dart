import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/product/product_item.dart';
import 'package:grand_uae/customer/product/product_list_model.dart';
import 'package:grand_uae/util/scroll_configuration.dart';

class ProductListView extends StatelessWidget {
  final List<Product> _products;

  ProductListView(this._products);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: getScrollPhysics(context),
      padding: const EdgeInsets.only(bottom: 92),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 600 ? 3 : 2,
        childAspectRatio: 0.85,
      ),
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductItem(_products[index]);
      },
    );
  }

  onNotification(ScrollNotification scrollInfo, ProductModel model) {
    if (scrollInfo is OverscrollNotification) {
      model.sink.add(scrollInfo);
    } else if (scrollInfo is UserScrollNotification) {
      model.sink.add(scrollInfo);
    }
    return false;
  }
}
