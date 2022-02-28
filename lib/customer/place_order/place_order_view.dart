import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/order.dart';
import 'package:grand_uae/customer/place_order/place_order_model.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class PlaceOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order completed"),
      ),
      body: Consumer2<PlaceOrderModel, CartProductModel>(
        builder: (context, model, cartModel, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return RetryButton(
              errorMessage: model.errorMessage,
              onPressed: () => model.placeOrder(),
            );
          }
          Order order = model.order;
          if (order == null) {
            if (model.orderId == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                      "Something went wrong!, please check the order completed?, from order history."),
                ),
              );
            }
            return RetryButton(
              errorMessage: "Please try again",
              onPressed: () => model.fetchOrderDetails(model.orderId),
            );
          }
          return Builder(
            builder: (_) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text("Order Id"),
                    subtitle: Text(order.orderId),
                  ),
                  ListTile(
                    title: Text('Price'),
                    subtitle: Text('${order.currencyCode} ${order.total}'),
                  ),
                  ListTile(
                    title: Text("Name"),
                    subtitle: Text(order.fullName),
                  ),
                  ListTile(
                    title: Text("Email"),
                    subtitle: Text(order.email),
                  ),
                  ListTile(
                    title: Text("Phone"),
                    subtitle: Text(order.telephone),
                  ),
                  ListTile(
                    title: Text("Address"),
                    subtitle: Text(order.fullAddress),
                  ),
                  ListTile(
                    title: Text("Invoice"),
                    subtitle: Text('${order.invoicePrefix}-${order.invoiceNo}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.all(16.0),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        model.navigateToHome(cartModel);
                      },
                      child: Text("Home"),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
