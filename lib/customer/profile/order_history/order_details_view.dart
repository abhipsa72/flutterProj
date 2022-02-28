import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/order.dart';

class OrderDetailsView extends StatelessWidget {
  final Order _order;

  OrderDetailsView(this._order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order details"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text("Order Id"),
            subtitle: Text(_order.orderId),
          ),
          ListTile(
            title: Text('Price'),
            subtitle: Text('${_order.currencyCode} ${_order.total}'),
          ),
          ListTile(
            title: Text("Name"),
            subtitle: Text(_order.fullName),
          ),
          ListTile(
            title: Text("Email"),
            subtitle: Text(_order.email),
          ),
          ListTile(
            title: Text("Phone"),
            subtitle: Text(_order.telephone),
          ),
          ListTile(
            title: Text("Address"),
            subtitle: Text('${_order.fullAddress}'),
          ),
          ListTile(
            title: Text("Order type"),
            subtitle: Text('${_order.shippingMethod}'),
          ),
          ListTile(
            title: Text("Order status"),
            subtitle: Text('${_order.orderStatus ?? 'N/A'}'),
          ),
          ListTile(
            title: Text("Date ordered"),
            subtitle: Text('${_order.dateAdded}'),
          ),
        ],
      ),
    );
  }
}
