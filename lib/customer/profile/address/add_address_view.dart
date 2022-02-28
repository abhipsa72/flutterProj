import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/zones_response.dart';
import 'package:grand_uae/customer/profile/address/add_address_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class AddAddressView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAddressModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add address"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
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
                  Consumer<AddAddressModel>(
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
                  model.errorMessage == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text(model.errorMessage)),
                        ),
                  MaterialButton(
                    disabledColor: Colors.grey,
                    color: Theme.of(context).accentColor,
                    padding: const EdgeInsets.all(16.0),
                    onPressed: model.state == ViewState.Idle
                        ? () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState.validate()) {
                              var success = await model.addAddressBook();
                              if (success) {
                                Navigator.of(context).pop(true);
                              }
                            }
                          }
                        : null,
                    child: model.state == ViewState.Idle ||
                            model.state == ViewState.Error
                        ? Text("Add address".toUpperCase())
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
          ),
        );
      },
    );
  }
}
