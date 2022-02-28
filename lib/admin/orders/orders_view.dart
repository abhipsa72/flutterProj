import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/enums/sort_with_order.dart';
import 'package:grand_uae/admin/model/order_status_response.dart';
import 'package:grand_uae/admin/model/orders_response.dart';
import 'package:grand_uae/admin/orders/orders_model.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        actions: [filterBuilder()],
      ),
      body: Consumer<OrdersModel>(
        builder: (_, model, child) {
          return PagewiseListView(
            pageLoadController: model.pageLoadController,
            loadingBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Loading",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            noItemsFoundBuilder: (_) => Text("No orders found"),
            itemBuilder: (context, order, index) {
              return ListTile(
                onTap: () => model.orderDetails(order),
                leading: Text(
                  order.orderId,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: Text(
                  order.customer,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(orderStatusValues.reverse[order.orderStatus]),
                trailing: Text(
                  order.totalPrice(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget filterBuilder() {
    return Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.sort),
        onPressed: () {
          showBottomSheet(
            elevation: 16,
            backgroundColor: Colors.grey[100],
            context: context,
            builder: (_) {
              return Consumer<OrdersModel>(
                builder: (_, model, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: model.customerController,
                        decoration: InputDecoration(
                          labelText: 'Customer',
                          hintText: 'Enter customer',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: model.amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          hintText: 'Enter amount',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: model.dateAddedController,
                        decoration: InputDecoration(
                          labelText: 'Date added',
                          hintText: 'YYYY-MM-DD',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: model.dateModifiedController,
                        decoration: InputDecoration(
                          labelText: 'Date modified',
                          hintText: 'YYYY-MM-DD',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Builder(
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                      SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<SortWithAdminOrder>(
                        value: model.sortWithAdminOrder,
                        hint: Text("Select sort"),
                        decoration: InputDecoration(
                          labelText: "Sort",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).highlightColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: SortWithAdminOrder.values.map((e) {
                          return DropdownMenuItem(
                            child: Text(getNameOfSort(e)),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (value) {
                          model.sortWithAdminOrder = value;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        onPressed: () {
                          //model.filterOrders();
                          Navigator.pop(context);
                        },
                        child: Text("Submit filter"),
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        onPressed: () {
                          model.fetchDetails();
                          Navigator.pop(context);
                        },
                        child: Text("Clear filter"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
