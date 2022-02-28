import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/profile/address_list/address_list_model.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/show_model.dart';
import 'package:provider/provider.dart';

class AddressListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddressListModel>(
      create: (context) => AddressListModel(),
      child: Consumer<AddressListModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Your addresses"),
            ),
            body: Consumer<AddressListModel>(
              builder: (context, model, child) {
                if (model.state == ViewState.Busy) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (model.state == ViewState.Error) {
                  return RetryButton(
                    errorMessage: model.errorMessage,
                    onPressed: () => model.fetchAccountDetails(),
                  );
                }
                if (model.addressBooks.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "You don't have any address yet, add one.",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FlatButton.icon(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: () async {
                              var success = await model.navigateToAddAddress();
                              if (success) {
                                model.fetchAccountDetails();
                              }
                            },
                            icon: Icon(Icons.add),
                            label: Text(
                              "Add Address",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 72.0),
                    itemCount: model.addressBooks.length,
                    itemBuilder: (_, index) {
                      AddressBook address = model.addressBooks[index];
                      return Stack(
                        children: [
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          address.fullName(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Text(
                                        address.address(),
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    model.defaultAddress != address
                                        ? OutlineButton(
                                            onPressed: () async {
                                              model.setDefaultAddress(address);
                                            },
                                            child: Text(
                                              "Set default",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    OutlineButton(
                                      onPressed: () async {
                                        var success = await model
                                            .navigateToEditAddress(address);
                                        if (success) {
                                          model.fetchAccountDetails();
                                        }
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    OutlineButton(
                                      onPressed: () {
                                        deleteAddress(
                                          context,
                                          address,
                                          model,
                                        );
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          model.defaultAddress == address
                              ? Positioned(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  right: 0,
                                )
                              : Container()
                        ],
                      );
                    },
                  );
                }
              },
            ),
            floatingActionButton: model.addressBooks.isNotEmpty
                ? FloatingActionButton.extended(
                    onPressed: () async {
                      var success = await model.navigateToAddAddress() ?? false;
                      if (success) {
                        model.fetchAccountDetails();
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add Address".toUpperCase()),
                  )
                : Container(),
          );
        },
      ),
    );
  }

  void deleteAddress(
    BuildContext context,
    AddressBook addressBook,
    AddressListModel model,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure want to delete the address!"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if (model.addressBooks.length > 1) {
                  model.deleteAddress(addressBook);
                } else {
                  showModel(
                    'You can\'t delete last address',
                    color: Colors.red,
                  );
                }
              },
              child: Text("Delete"),
            )
          ],
        );
      },
    );
  }
}
