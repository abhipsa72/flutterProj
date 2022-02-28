import 'package:flutter/material.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:provider/provider.dart';

class CartTotalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (BuildContext context, model, Widget child) {
        if (model.cartProducts.isEmpty) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: model.totalItems.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  e.title.replaceAll("-", " "),
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                e.text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
