import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/order.dart';
import 'package:grand_uae/customer/profile/order_history/order_history_model.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class OrderHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: Consumer<OrderHistoryModel>(
        builder: (_, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.state == ViewState.Error) {
            return RetryButton(
              errorMessage: model.errorMessage ??
                  "Something went wrong please try again.",
              onPressed: () => model.fetchOrderHistory(),
            );
          }
          return ListView.builder(
            itemCount: model.orderList.length,
            itemBuilder: (_, index) {
              Order order = model.orderList[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    model.orderDetailsView(order);
                  },
                  title: Text(order.fullName),
                  subtitle: Text('${order.currencyCode} ${order.total}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
