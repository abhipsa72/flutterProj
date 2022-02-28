import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/action.dart';
import 'package:zel_app/model/alarm.dart';
import 'package:zel_app/model/login_response.dart';
import 'package:zel_app/model/store_product.dart';
import 'package:zel_app/model/sub_action.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/store_manager/store_manager.dart';

class StoreManagerProductDetails extends StatefulWidget {
  @override
  _StoreManagerProductDetailsState createState() =>
      _StoreManagerProductDetailsState();
}

class _StoreManagerProductDetailsState
    extends State<StoreManagerProductDetails> {
  bool _barCode = false;
  bool _remarkable = false;
  var _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  final TextEditingController _barCodeController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  String validateBarCode(String value) {
    if (value.isEmpty) {
      return "Barcode is empty";
    } else
      return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _productDetails = Provider.of<ProductListingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
        bottom: PreferredSize(
          child: ToolbarProgress(_productDetails.isLoading),
          preferredSize: Size(double.infinity, 2.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ProductTable(_productDetails.productStream),
                StreamProvider<List<Alarm>>(
                  initialData: List<Alarm>(),
                  create: (context) => _productDetails.alarmsStream,
                  child: Consumer<List<Alarm>>(
                    builder: (_, List<Alarm> alarms, child) {
                      if (alarms.isEmpty) {
                        return Container();
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Alarms",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Alarm"),
                        value: _productDetails.selectedAlarm,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (Alarm val) {
                          setState(() {
                            _productDetails.setSelectedAlarm = val;
                            _remarkable = false;
                            _barCode = false;
                          });
                        },
                        items: alarms.map((alarm) {
                          return DropdownMenuItem(
                            child: Text(alarm.alarmName),
                            value: alarm,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                StreamProvider<List<AlarmAction>>(
                  initialData: List<AlarmAction>(),
                  create: (context) => _productDetails.actionsStream,
                  child: Consumer<List<AlarmAction>>(
                    builder: (_, List<AlarmAction> actions, child) {
                      if (actions.isEmpty || actions == null) {
                        return Container();
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Actions",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Action"),
                        value: _productDetails.selectedAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (AlarmAction val) {
                          setState(() {
                            _productDetails.setSelectedAction = val;
                            if (val.action == "Others") {
                              _remarkable = true;
                              _barCode = false;
                            } else
                              _remarkable = false;
                            _barCode = false;
                            _productDetails.level4Sink.add(List<String>());
                          });
                        },
                        items: actions.map((alarmAction) {
                          return DropdownMenuItem(
                            child: Text(alarmAction.action),
                            value: alarmAction,
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
                  initialData: List<SubAction>(),
                  create: (context) => _productDetails.subActionsStream,
                  child: Consumer<List<SubAction>>(
                    builder: (_, List<SubAction> subActions, child) {
                      if (subActions.isEmpty || subActions == null) {
                        return Container();
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Sub actions",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select sub action"),
                        value: _productDetails.selectedSubAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (SubAction val) {
                          setState(() {
                            _productDetails.setSelectedSubAction = val;
                            if (val.subActionName.toLowerCase() ==
                                "product in same subgroup") {
                              _barCode = true;
                              _remarkable = false;
                            } else if (val.subActionName.toLowerCase() ==
                                "product in different subgroup") {
                              _remarkable = true;
                              _barCode = false;
                            } else {
                              _remarkable = false;
                              _barCode = false;
                              _productDetails.level4Sink.add(List<String>());
                            }
                          });
                        },
                        items: subActions.map((alarmAction) {
                          return DropdownMenuItem(
                            child: Text(alarmAction.subActionName),
                            value: alarmAction,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                _barCode
                    ? TextFormField(
                        validator: validateBarCode,
                        keyboardType: TextInputType.emailAddress,
                        controller: _barCodeController,
                        maxLines: 1,
                        onChanged: _productDetails.setBarCode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "specify same subgroup",
                          //labelText: "Barcode",
                          //prefixIcon: Icon(Icons.code),
                        ),
                      )
                    : Container(),
                _remarkable
                    ? TextFormField(
                        validator: validateBarCode,
                        keyboardType: TextInputType.emailAddress,
                        controller: _remarkController,
                        onChanged: _productDetails.setRemarks,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "specify different subgroup",
                          // labelText: "Remarks",
                          //prefixIcon: Icon(Icons.store_mall_directory),
                        ),
                      )
                    : Container(),
                StreamProvider(
                  initialData: List<String>(),
                  create: (context) => _productDetails.level4Stream,
                  child: Consumer(
                    builder: (_, List<String> options, child) {
                      if (options.isEmpty) {
                        return Container();
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Sub action",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select sub action"),
                        value: _productDetails.selected4Option,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (String val) {
                          setState(() {
                            _productDetails.setSelected4Action = val;
                            if (val == "Bought by store manager?") {
                              _productDetails.updateRole(
                                _productDetails.product.id,
                                Roles.ROLE_STORE_MANAGER,
                              );
                            } else {
                              _productDetails.updateRole(
                                _productDetails.product.id,
                                Roles.ROLE_PURCHASER,
                              );
                            }
                          });
                        },
                        items: options.map((actionName) {
                          return DropdownMenuItem(
                            child: Text(actionName),
                            value: actionName,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_productDetails.selectedSubAction == null) {
                        _productDetails.saveAction();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => StoreManagerPage(),
                            ),
                            (route) => false);
                      } else {
                        _productDetails.saveDetails();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => StoreManagerPage(),
                            ),
                            (route) => false);
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

    return StreamBuilder<StoreProduct>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          StoreProduct product = snapshot.data;
          return Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Product code",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.productCode.toString()),
                  ),
                ],
              ),
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
                    child: Text(departmentValues.reverse[product.department]
                        .toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Store",
                      style: headerText,
                    ),
                  ),
                  Padding(padding: padding, child: Text(product.store)),
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
                      "d0 Sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0Sales.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "d1 Sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1Sales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "d7 Sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7Sales.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg Sale",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgSales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg sale",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgSales.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Pred sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.predSales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D0 trans",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0Trans.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D1 trans",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1Trans.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D7 trans",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7Trans.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg trans",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgTrans.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg trans",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgTrans.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D0 Qty",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0Qty.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D1 Qty",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1Qty.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D7 Qty",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7Qty.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg Qty",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgQty.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg qty",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgQty.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D0 price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0Price.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D1 price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1Price.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D7 price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7Price.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgPrice.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Av price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgPrice.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg price",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgPrice.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D0 promo",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0Promo.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D1 promo",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1Promo.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D7 promo",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7Promo.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg promo",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgPromo.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg promo",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgPromo.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D0 Sgrp sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d0SgrpSales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D1 Sgrp sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d1SgrpSales.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "D7 Sgrp sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.d7SgrpSales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Avg Sgrp sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.avgSgrpSales.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "oE Avg Sgrp sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.oEAvgSgrpSales.toString()),
                  ),
                ],
              ),
              // TableRow(
              //   children: [
              //     Padding(
              //       padding: padding,
              //       child: Text(
              //         "d0_Opening_Stock",
              //         style: headerText,
              //       ),
              //     ),
              //     Padding(
              //       padding: padding,
              //       child: Text(product.d0OpeningStock.toString()),
              //     ),
              //   ],
              // ),
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
                    child: product.warehouseStock == null
                        ? Text("Na")
                        : Text(product.warehouseStock.toString()),
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
                    child: product.storeStock == null
                        ? Text("NA")
                        : Text(product.storeStock.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "rules broke",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.rulesBroken.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Probable reasons",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(probableReasonsValues
                        .reverse[product.probableReasons]
                        .toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "suggestions",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.suggestions.toString()),
                  ),
                ],
              ),
              // TableRow(
              //   children: [
              //     Padding(
              //       padding: padding,
              //       child: Text(
              //         "remarks",
              //         style: headerText,
              //       ),
              //     ),
              //     Padding(
              //       padding: padding,
              //       child: Text(product.remarks.toString()),
              //     ),
              //   ],
              // ),
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
                    child: Text(product.createDate.toString()),
                  ),
                ],
              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "alarm_Id",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.alarmId.toString()),
//                  ),
//                ],
//              ),
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
//                    child: Text(product.actionName.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "action_Id",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.actionId.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "completed",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.completed.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "closingDate",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.closingDate.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "timeTaken",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.timeTaken.toString()),
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
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "referedBy",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.referedBy.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "subActionName",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.subActionName.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "subActionId",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.subActionId.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "subActionRemarks",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.subActionRemarks.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "barCode",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.barCode.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                    "finalWorkflowPermission",
//                    style: headerText,
//                  ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.finalWorkflowPermission.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "finalWorkflowId",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.finalWorkflowId.toString()),
//                  ),
//                ],
//              ),
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
//                    child: Text(product.targetDays.toString()),
//                  ),
//                ],
//              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "supplier_1_Code",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.supplier1Code.toString()),
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
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "supplier_2_Code",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.supplier2Code.toString()),
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
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "assignedSupplierId",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.assignedSupplierId.toString()),
//                  ),
//                ],
//              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "region",
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

  final Stream<StoreProduct> _product;

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
