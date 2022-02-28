import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductItem extends StatelessWidget {
  final Product _product;
  final NavigationService _navigationService = locator<NavigationService>();

  ProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          _navigationService.navigateTo(
            routes.ProductDetailsRoute,
            arguments: _product.productId,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: NetworkProductImage(
                imageUrl: _product.image,
                isBoxFitContain: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                _product.name.toHtmlUnescapeCapitalize(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            _product.manufacturer != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      "${_product.manufacturer}",
                      style: TextStyle(
                        fontSize: 9,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _product.price,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Consumer<CartProductModel>(
              builder: (context, model, child) {
                var cartProduct = LocalCartProduct(
                  _product.productId,
                  0,
                );
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
                    onPressed: () async {
                      var success = await model.checkLoginOrNot();
                      if (success) {
                        cartProduct.quantity += 1;
                        model.addCartProducts(cartProduct);
                      }
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
                        size: 24,
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
                        size: 24,
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
