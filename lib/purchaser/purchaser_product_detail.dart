import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/permission.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/purchaser/purchaser_page_provider.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_product_detail.dart';

import 'home/purchaser_home_page.dart';

class PurchaserProductDetails extends StatefulWidget {
  @override
  _PurchaserProductDetailsState createState() =>
      _PurchaserProductDetailsState();
}

class _PurchaserProductDetailsState extends State<PurchaserProductDetails> {
  final _numberController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
        bottom: PreferredSize(
          child: ToolbarProgress(_provider.isLoading),
          preferredSize: Size(double.infinity, 2.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProductTable(_provider.productStream),
              StreamBuilder<Product>(
                stream: _provider.productStream,
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    Product product = snapshot.data;

                    final List<String> supplierNames = List();
                    if (product.supplier1Name != null) {
                      supplierNames.add(product.supplier1Name);
                    }
                    if (product.supplier2Name != null) {
                      if (product.supplier2Name == "None") {
                        supplierNames.add("");
                      } else {
                        supplierNames.add(product.supplier2Name);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _provider.selectedSupplier,
                        isExpanded: true,
                        isDense: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Supplier",
                          enabledBorder: OutlineInputBorder(),
                        ),
                        hint: Text(
                          "Select supplier",
                        ),
//                      selectedItemBuilder: (BuildContext context) {
//                        return supplierNames.map<Widget>((String text) {
//                          return Text(
//                            text,
//                            overflow: TextOverflow.ellipsis,
//                          );
//                        }).toList();
//                      },
                        items: supplierNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (String val) {
                          setState(() {
                            _provider.setSelectedSupplier = val;
                          });
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              StreamProvider(
                create: (context) => _provider.permissionsStream,
                initialData: List<WarehouseAction>(),
                child: Consumer<List<WarehouseAction>>(
                  builder: (_, List<WarehouseAction> actions, child) {
                    //print("PActions $actions");
                    if (actions.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<WarehouseAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Actions",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text("Select action"),
                        value: _provider.selectedAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (WarehouseAction val) {
                          setState(() {
                            _provider.setSelectedAction = val;
                            if (val.hasRole == 3) {
                              _provider.getSubActionsByAction(val.id);
                            } else {
                              _provider.subActionsSink
                                  .add(List<WarehouseAction>());
                            }
                          });
                        },
                        selectedItemBuilder: (BuildContext context) {
                          return actions.map<Widget>((action) {
                            return Text(
                              action.permission,
                              overflow: TextOverflow.ellipsis,
                            );
                          }).toList();
                        },
                        items: actions.map((action) {
                          return DropdownMenuItem(
                            child: Text(
                              action.permission,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: action,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              StreamProvider(
                create: (context) => _provider.subActionsStream,
                initialData: List<WarehouseAction>(),
                child: Consumer<List<WarehouseAction>>(
                  builder: (_, List<WarehouseAction> actions, child) {
                    if (actions.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<WarehouseAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Sub Actions",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text("Select sub action"),
                        value: _provider.selectedSubAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (WarehouseAction val) {
                          setState(() {
                            _provider.setSelectedSubAction = val;
                            if (val.permission == "Local Market Purchase") {
                              _provider.getReasignByAction(val.id);
                            } else {
                              _provider.asignSink.add(List<WarehouseAction>());
                            }
                          });
                        },
                        items: actions.map((action) {
                          return DropdownMenuItem(
                            child: Text(
                              action.permission,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: action,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              StreamProvider(
                create: (context) => _provider.asignStream,
                initialData: List<WarehouseAction>(),
                child: Consumer<List<WarehouseAction>>(
                  builder: (_, List<WarehouseAction> actions, child) {
                    if (actions.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<WarehouseAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "ASIGN",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text("Select sub action"),
                        value: _provider.selectedAsign,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (WarehouseAction val) {
                          setState(() {
                            _provider.setSelectedAsign = val;
//
                          });
                        },
                        items: actions.map((action) {
                          return DropdownMenuItem(
                            child: Text(
                              action.permission,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: action,
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  maxLines: 1,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[1-9][.0-9]*$')),
                  ],
                  onChanged: _provider.numberOfTargetDays,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: "Enter target days",
                    labelText: "Target days",
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                padding: const EdgeInsets.all(16.0),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (_provider.selectedAsign == null) {
                      _provider.saveDetails();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PurchaserPage(),
                        ),
                      );
                      _provider.setSupplierToNull();
                      _provider.setActionToNull();
                      _provider.setSubActionToNull();
                      //_provider.setAsignToNull();
                    } else {
                      _provider.saveAsign();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PurchaserPage(),
                        ),
                      );
                      _provider.setSupplierToNull();
                      _provider.setActionToNull();
                      _provider.setSubActionToNull();
                      _provider.setAsignToNull();
                    }
                  } else {
                    setState(() {
                      _autovalidate = true; //enable realtime validation
                    });
                  }
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ToolbarProgress extends StatelessWidget {
  final Stream<bool> _isLoading;

  ToolbarProgress(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLoading,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          );
        } else
          return Container();
      },
    );
  }
}
