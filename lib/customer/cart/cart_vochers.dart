import 'package:flutter/material.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:provider/provider.dart';

class CartVouchers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, model, child) {
        if (model.vouchersItems.isEmpty) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Coupons",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            model.vouchersItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("No coupons available"),
                  )
                : Container(),
            Divider(
              height: 24,
            ),
          ],
        );
      },
    );
  }
}
