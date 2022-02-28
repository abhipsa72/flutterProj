import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/customer/customers_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class CustomersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
        actions: [filterBuilder()],
      ),
      body: Consumer<CustomersModel>(
        builder: (context, model, child) {
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
            noItemsFoundBuilder: (_) => Text("No customers found"),
            itemBuilder: (context, customer, index) {
              return ListTile(
                title: Text(customer.name),
                subtitle: Text(customer.email),
                trailing: IconButton(
                  onPressed: () {
                    model.deleteCustomer(customer);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
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
              return Consumer<CustomersModel>(
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
                        controller: model.nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter name',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: model.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter email',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        onPressed: () {
                          model.filterOrders();
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
                          model.clearDetails();
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
