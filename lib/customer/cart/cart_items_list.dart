import 'package:flutter/material.dart';
import 'package:grand_uae/customer/cart/cart_item.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:provider/provider.dart';

class CartItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (_, model, child) {
        if (model.cartProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 72,
                  ),
                ),
                Text(
                  "Empty items",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          );
        }
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.cartProducts.length,
            itemBuilder: (_, index) {
              Product product = model.cartProducts[index];
              return CartItem(product, model);
            },
          ),
        );
      },
    );
  }
}
