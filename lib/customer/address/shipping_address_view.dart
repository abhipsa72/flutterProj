import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/address/shipping_address_model.dart';
import 'package:grand_uae/customer/model/zones_response.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class ShippingAddressView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShippingAddressViewModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Shipping address"),
          ),
          body: Builder(
            builder: (context) {
              if (model.state == ViewState.Busy) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (model.state == ViewState.Error) {
                return RetryButton(
                  onPressed: () {},
                  errorMessage: model.message,
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  model.refresh();
                },
                child: SingleChildScrollView(
                  child: buildForm(context, model),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _focusChange(
    BuildContext context,
    FocusNode currentNode,
    FocusNode nextFocus,
  ) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  buildForm(BuildContext context, ShippingAddressViewModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Icon(Icons.pin_drop),
            title: Text(
              "Use default address",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              model.addressBook != null
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        model.addressBook.addressString() ?? "Address",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Text(
                      "No default address found, add address from profile!",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  disabledColor: Colors.grey,
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(16.0),
                  onPressed:
                      model.state == ViewState.Idle && model.addressBook != null
                          ? () {
                              model.setDefaultAddressToOrder();
                            }
                          : null,
                  child: model.state == ViewState.Idle
                      ? Text(
                          "Use default address".toUpperCase(),
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
              ),
            ],
          ),
          Builder(
            builder: (_) {
              if (model.addressBooks.isEmpty) {
                return ExpansionTile(
                  title: Text("My Address"),
                  children: [
                    ListTile(
                      title: Text("No address"),
                    )
                  ],
                );
              }
              return ExpansionTile(
                leading: Icon(Icons.location_pin),
                title: Text(
                  "My saved addresses",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: model.addressBooks
                        .map((address) => ListTile(
                              title: Text(address.fullName()),
                              subtitle: Text(address.addressString()),
                              onTap: () {
                                model.setSelectedAddressToOrder(address);
                              },
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              trailing: FlatButton(
                                child: Text(
                                  "Select",
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                onPressed: () {
                                  model.setSelectedAddressToOrder(address);
                                },
                              ),
                            ))
                        .toList(),
                  )
                ],
              );
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.add_location_alt_sharp),
            title: Text(
              "Add address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        focusNode: model.addressNode,
                        onFieldSubmitted: (val) {
                          _focusChange(
                              context, model.addressNode, model.address2Node);
                        },
                        validator: validateAddress,
                        controller: model.address1Controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Address 1",
                          hintText: "Enter address 1",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        focusNode: model.address2Node,
                        onFieldSubmitted: (val) {
                          _focusChange(
                              context, model.address2Node, model.cityNode);
                        },
                        validator: validateAddress,
                        controller: model.address2Controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Address 2 ",
                          hintText: "Enter address 2",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        focusNode: model.cityNode,
                        onFieldSubmitted: (val) {
                          _focusChange(context, model.cityNode, model.postNode);
                        },
                        validator: validateCity,
                        controller: model.cityController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "City",
                          hintText: "Enter city",
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Consumer<ShippingAddressViewModel>(
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                        focusNode: model.postNode,
                        onFieldSubmitted: (val) {
                          model.cityNode.unfocus();
                        },
                        maxLength: 6,
                        validator: postCodeValidation,
                        controller: model.postalCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Post code",
                          hintText: "Enter post code",
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
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        disabledColor: Colors.grey,
                        color: Theme.of(context).accentColor,
                        padding: const EdgeInsets.all(16.0),
                        onPressed: model.state == ViewState.Idle
                            ? () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (_formKey.currentState.validate()) {
                                  model.setAddressToOrder();
                                }
                              }
                            : null,
                        child: model.state == ViewState.Idle
                            ? Text(
                                "Add address".toUpperCase(),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
