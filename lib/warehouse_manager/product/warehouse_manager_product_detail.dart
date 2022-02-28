import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/permission.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_page.dart';
import 'package:zel_app/warehouse_manager/warehouse_manager_provider.dart';

class WarehouseProductDetailsPage extends StatefulWidget {
  @override
  _WarehouseProductDetailsPageState createState() =>
      _WarehouseProductDetailsPageState();
}

class _WarehouseProductDetailsPageState
    extends State<WarehouseProductDetailsPage> {
  final _numberController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<WarehouseManagerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
        bottom: PreferredSize(
          child: ToolbarProgress(_provider.isLoadingStream),
          preferredSize: Size(double.infinity, 2.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
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
                        if (product.supplier1Name == "None" &&
                            product.supplier2Name == "None") {
                          supplierNames.add("");
                        } else {
                          supplierNames.add(product.supplier2Name);
                        }
                      }
                      return DropdownButtonFormField<String>(
                        value: _provider.selectedSupplier,
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: "Supplier",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select supplier"),
                        items: supplierNames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String val) {
                          setState(() {
                            _provider.setSelectedSupplier = val;
                          });
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                StreamProvider(
                  create: (context) => _provider.permissionsStream,
                  initialData: List<WarehouseAction>(),
                  child: Consumer<List<WarehouseAction>>(
                    builder: (_, List<WarehouseAction> actions, child) {
                      if (actions.isEmpty) {
                        return Container();
                      }
                      return DropdownButtonFormField<WarehouseAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Actions",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
                              //overflow: TextOverflow.ellipsis,
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
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                StreamProvider(
                  create: (context) => _provider.subActionsStream,
                  initialData: List<WarehouseAction>(),
                  child: Consumer<List<WarehouseAction>>(
                    builder: (_, List<WarehouseAction> actions, child) {
                      if (actions.isEmpty) {
                        return Container();
                      }
                      return DropdownButtonFormField<WarehouseAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Sub Actions",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select sub action"),
                        value: _provider.selectedSubAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (WarehouseAction val) {
                          setState(() {
                            _provider.setSelectedSubAction = val;
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
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
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
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _provider.saveDetails();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WarehouseHomePage(),
                        ),
                      );
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
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);

    return StreamBuilder<Product>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Product product = snapshot.data;
          return Table(
            children: [
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Description",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.description),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Division",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(departmentValue.reverse[product.department]),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Category",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.category),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Store name",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.storeName.toString()),
                  ),
                ],
              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "Sub Group",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.subGroup),
//                  ),
//                ],
//              ),

//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "remarks",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.remarks.toString()),
//                  ),
//                ],
//              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Create date",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.date.toString()),
                  ),
                ],
              ),

//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "action_Name",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.action.toString()),
//                  ),
//                ],
//              ),

//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "referedRole",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.referedRole.toString()),
//                  ),
//                ],
//              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Refered by",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.currentRole.toString()),
                  ),
                ],
              ),

              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Store stock",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.storeStock.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Warehouse stock",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.warehouseStock.toString()),
                  ),
                ],
              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "targetDays",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.days.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "supplier_1_Name",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.supplier1Name.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "supplier_2_Name",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.supplier2Name.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "assignedFrom",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.assignedFrom?.name ?? "None"),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "assignedSupplier",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.assignedSupplier.toString()),
//                  ),
//                ],
//              ),

              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Region",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.region),
                  ),
                ],
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }

  final Stream<Product> _product;

  ProductTable(this._product);
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
