import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:grand_uae/util/strings.dart';

class CartItem extends StatelessWidget {
  final Product _product;
  final CartModel _cartModel;

  CartItem(this._product, this._cartModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: NetworkProductImage(
              imageUrl: _product.image,
              isBoxFitContain: false,
            ), //_product.image,
            width: 86,
            height: 86,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _product.name.toLowerCase().firstLetterToUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: _product.stock ? Colors.black : Colors.red,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " x${_product.quantity}",
                        style: Theme.of(context).textTheme.caption,
                        children: [],
                      ),
                    ],
                    text: "${_product.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _cartModel.showEditDialog(_product);
              },
            ),
            IconButton(
              onPressed: () {
                _cartModel.showDeleteDialog(_product);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
