import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:provider/provider.dart';

class ProductStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalCartProduct cartProduct = LocalCartProduct(_productId, 0);
    return Consumer<CartProductModel>(
      builder: (_, model, child) {
        cartProduct.quantity = model.value.firstWhere(
            (e) => e.productId == cartProduct.productId, orElse: () {
          return cartProduct;
        }).quantity;
        if (cartProduct.quantity == 0) {
          return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cartProduct.quantity += 1;
              model.addCartProducts(cartProduct);
            },
            child: Text(
              "Add to cart",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                cartProduct.quantity -= 1;
                model.addCartProducts(cartProduct);
              },
              icon: Icon(
                Icons.remove_circle,
                color: Theme.of(context).accentColor,
                size: _iconSize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${cartProduct.quantity ?? 0}",
                style: TextStyle(fontSize: 22),
              ),
            ),
            IconButton(
              onPressed: () {
                cartProduct.quantity += 1;
                model.addCartProducts(cartProduct);
              },
              icon: Icon(
                Icons.add_circle,
                color: Theme.of(context).accentColor,
                size: _iconSize,
              ),
            )
          ],
        );
      },
    );
  }

  final String _productId;
  final double _iconSize;

  ProductStepper(this._productId, this._iconSize);
}
