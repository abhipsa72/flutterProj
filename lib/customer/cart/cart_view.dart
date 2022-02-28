import 'package:flutter/material.dart';
import 'package:grand_uae/customer/cart/cart_items_list.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:grand_uae/customer/cart/cart_total_view.dart';
import 'package:grand_uae/customer/cart/cart_vochers.dart';
import 'package:grand_uae/customer/enums/connectivity_status.dart';
import 'package:grand_uae/customer/views/error_network.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityStatus>(
      builder: (_, connectivityModel, child) {
        if (connectivityModel == ConnectivityStatus.Offline) {
          return NoInternet();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart items"),
            bottom: PreferredSize(
              child: Consumer<CartModel>(
                builder: (_, model, child) {
                  if (model.state == ViewState.Busy) {
                    return SizedBox(
                      height: 2.0,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).textTheme.headline6.color,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              preferredSize: Size(double.infinity, 0.5),
            ),
          ),
          body: Consumer<CartModel>(
            builder: (_, model, child) {
              if (model.state == ViewState.Error) {
                return RetryButton(
                  onPressed: () => model.fetchCartItems(),
                  errorMessage: model.errorMessage,
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  model.fetchCartItems();
                },
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    model.isMinimumOrder
                        ? Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                model.minimumOrderTotal['warning'],
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    CartTotalView(),
                    Divider(
                      height: 24,
                    ),
                    CartVouchers(),
                    CartItemsList(),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Theme.of(context).accentColor,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        "Add more products",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<CartModel>(
                    builder: (_, model, child) {
                      return MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        color: Theme.of(context).accentColor,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.white,
                        onPressed: model.isMinimumOrder ||
                                model.state == ViewState.Busy
                            ? null
                            : () {
                                model.checkoutCart();
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Checkout",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
