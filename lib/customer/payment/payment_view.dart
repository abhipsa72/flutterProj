import 'package:flutter/material.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/payment/payment_model.dart';
import 'package:provider/provider.dart';

class ChoosePaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Consumer<ChoosePaymentViewModel>(
        builder: (_, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return RetryButton(
              errorMessage: model.errorMessage,
              onPressed: () => model.fetchPaymentMethods(),
            );
          }
          if (model.paymentMethods.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text("No payment methods")),
            );
          }
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListView.builder(
                    itemCount: model.paymentMethods.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      var method = model.paymentMethods[index];
                      return RadioListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text(method.title),
                        value: method,
                        groupValue: model.selectedPayment,
                        onChanged: (val) {
                          model.selectedPayment = val;
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MaterialButton(
                    disabledColor: Colors.grey,
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: model.selectedPayment != null
                        ? () {
                            model.setPaymentMethod();
                          }
                        : null,
                    child: model.state == ViewState.Idle
                        ? Text(
                            "Place order".toUpperCase(),
                            style: TextStyle(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.grey[600],
                                  ),
                                  strokeWidth: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  "Loading",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
