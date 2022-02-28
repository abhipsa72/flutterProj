import 'package:flutter/material.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/customer/model/account_response.dart';
import 'package:grand_uae/customer/model/zones_response.dart';
import 'package:grand_uae/customer/profile/edit_address/edit_address_model.dart';
import 'package:grand_uae/validators.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:provider/provider.dart';

class EditAddressView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit address"),
      ),
      body: Consumer<EditAddressModel>(
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return RetryButton(
              errorMessage: model.message,
              onPressed: () => model.fetchDetails(),
            );
          }
          AddressBook _addressBook = model.sendAddressBook;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    initialValue: _addressBook.firstname,
                    keyboardType: TextInputType.name,
                    onChanged: (val) {
                      model.sendAddressBook.firstname = val;
                    },
                    validator: validateName,
                    decoration: InputDecoration(
                      labelText: "First name",
                      hintText: "Enter first name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: _addressBook.lastname,
                    keyboardType: TextInputType.name,
                    validator: validateLastName,
                    onChanged: (val) {
                      model.sendAddressBook.lastname = val;
                    },
                    decoration: InputDecoration(
                      labelText: "Last name",
                      hintText: "Enter last name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: _addressBook.address1,
                    keyboardType: TextInputType.streetAddress,
                    onChanged: (val) {
                      model.sendAddressBook.address1 = val;
                    },
                    validator: validateAddress,
                    decoration: InputDecoration(
                      labelText: "Address 1",
                      hintText: "Enter address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: _addressBook.address2,
                    keyboardType: TextInputType.streetAddress,
                    onChanged: (val) {
                      model.sendAddressBook.address2 = val;
                    },
                    validator: validateAddress,
                    decoration: InputDecoration(
                      labelText: "Address 2",
                      hintText: "Enter address or landmark",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: _addressBook.city,
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      model.sendAddressBook.city = val;
                    },
                    validator: validateCity,
                    decoration: InputDecoration(
                      labelText: "City",
                      hintText: "Enter city",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Consumer<EditAddressModel>(
                    builder: (_, address, child) {
                      if (address.zones == null) {
                        return Container();
                      }
                      if (address.zones.isEmpty) {
                        return Container();
                      }
                      return DropdownButtonFormField<Zone>(
                        value: address.selectedZone,
                        hint: Text("Select Region"),
                        decoration: InputDecoration(
                          labelText: "Regions",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).highlightColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: address.zones.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (Zone value) {
                          address.selectedZone = value;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue: _addressBook.postcode,
                    onChanged: (val) {
                      model.sendAddressBook.postcode = val;
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: validateAddress,
                    decoration: InputDecoration(
                      labelText: "Postal",
                      hintText: "Enter postal",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: model.isUseDefault,
                        onChanged: (bool value) {
                          model.isUseDefault = value;
                        },
                      ),
                      Expanded(
                        child: Text("Use as default address"),
                      )
                    ],
                  ),
                  MaterialButton(
                    disabledColor: Colors.grey,
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: model.state == ViewState.Idle
                        ? () async {
                            var success = await model.updateAddressBook(
                              _addressBook.addressId,
                            );
                            if (success) {
                              Navigator.of(context).pop(true);
                            }
                          }
                        : null,
                    child: model.state == ViewState.Idle
                        ? Text(
                            "Update address".toUpperCase(),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
