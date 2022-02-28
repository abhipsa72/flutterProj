import 'package:flutter/material.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/views/cart_menu_item_tracker.dart';
import 'package:provider/provider.dart';

import 'color_circular_indicator.dart';

class PlaceOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProductModel>(
      builder: (_, model, child) {
        if (model.value.isNotEmpty) {
          return FloatingActionButton.extended(
            onPressed: () {
              model.clearCart();
            },
            label: Text(
              model.isLoading ? "Adding items to cart" : "Place order",
              style: TextStyle(fontSize: 18),
            ),
            icon: model.isLoading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: ColorProgress(Colors.black),
                  )
                : CartMenuItemTracker(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
