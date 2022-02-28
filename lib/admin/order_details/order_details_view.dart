import 'package:flutter/material.dart';
import 'package:grand_uae/admin/model/order_details_response.dart';
import 'package:grand_uae/admin/model/order_status_response.dart';
import 'package:grand_uae/admin/model/products_order_response.dart';
import 'package:grand_uae/admin/order_details/order_details_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class AdminOrderDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order details"),
        actions: [
          Consumer<AdminOrderDetailsModel>(
            builder: (_, model, child) {
              return IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Confirmation!'),
                        content: Text('Are you sure about deleting the order?'),
                        actions: [
                          FlatButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          FlatButton(
                            onPressed: () async {
                              var success = await model.deleteOrder();
                              if (success) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Delete'),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
      body: Consumer<AdminOrderDetailsModel>(
        builder: (_, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return Center(
              child: Text(model.errorMessage),
            );
          }
          OrderDetails _order = model.orderDetails;
          return ListView(
            children: [
              Container(
                height: 156,
                child: Builder(builder: (_) {
                  if (model.orderProducts.isEmpty) {
                    return Container();
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.orderProducts.length,
                    itemBuilder: (_, index) {
                      OrderProduct op = model.orderProducts[index];
                      return Container(
                        height: 156,
                        width: 112,
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(op.name),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  op.price,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
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
                title: Text("Date ordered"),
                subtitle: Text('${_order.dateAdded}'),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Builder(
                  builder: (_) {
                    if (model.orderStatuses == null) {
                      return Container();
                    }
                    if (model.orderStatuses.isEmpty) {
                      return Container();
                    }
                    return DropdownButtonFormField<Status>(
                      value: model.selectStatus,
                      hint: Text("Select status"),
                      decoration: InputDecoration(
                        labelText: "Status",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).highlightColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: model.orderStatuses.map((e) {
                        return DropdownMenuItem(
                          child: Text(e.name),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (Status value) {
                        model.selectStatus = value;
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledColor: Colors.grey,
                  padding: const EdgeInsets.all(16),
                  onPressed: model.state == ViewState.Idle
                      ? () async => model.updateStatus()
                      : null,
                  color: Theme.of(context).accentColor,
                  child: model.state == ViewState.Idle
                      ? Text(
                          "Update status",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
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
                                "Updating",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              ListTile(
                title: Text(model.errorMessage),
              ),
              SizedBox(
                height: 72,
              ),
            ],
          );
        },
      ),
    );
  }
}
