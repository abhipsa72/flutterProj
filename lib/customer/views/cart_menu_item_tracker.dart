import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/views/color_circular_indicator.dart';
import 'package:grand_uae/show_model.dart';
import 'package:provider/provider.dart';

class CartMenuItemTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProductModel>(
      builder: (_, model, Widget child) {
        return model.isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: ColorProgress(
                      Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ),
              )
            : Builder(
                builder: (BuildContext context) {
                  return Badge(
                    badgeColor: Theme.of(context).canvasColor,
                    position: BadgePosition.topEnd(
                      top: 0,
                      end: 3,
                    ),
                    animationDuration: Duration(
                      milliseconds: 300,
                    ),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      "${context.watch<CartProductModel>().value.length}"
                          .toString(),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontSize: 11,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        if (model.value.isNotEmpty) {
                          model.clearCart();
                        } else {
                          showModel(
                            "Please add items to cart!",
                          );
                        }
                      },
                    ),
                  );
                },
              );
      },
    );
  }
}
