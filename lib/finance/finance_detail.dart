import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/finance_action.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/store_manager/product/product_details_page.dart';

import 'finance_home_page.dart';
import 'finance_page_provider.dart';

class FinanceDetails extends StatefulWidget {
  @override
  _FinanceDetailsState createState() => _FinanceDetailsState();
}

class _FinanceDetailsState extends State<FinanceDetails> {
  final _numberController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<FinanceProviderBloc>(context);
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
                        isDense: true,
                        decoration: InputDecoration(
                          labelText: "Supplier",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(),
                        ),
                        hint: Text(
                          "Select supplier",
                        ),
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
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              StreamProvider(
                initialData: List<FinanceAction>(),
                create: (context) => _provider.actionsStream,
                child: Consumer<List<FinanceAction>>(
                  builder: (_, List<FinanceAction> actions, child) {
                    if (actions.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<FinanceAction>(
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
                        onChanged: (FinanceAction val) {
                          setState(() {
                            _provider.setSelectedAction = val;
                            if (val.hasRole == 3) {
                              _provider.getSubActions(val.id);
                            } else {
                              _provider.subActionsSink
                                  .add(List<FinanceAction>());
                            }
                          });
                        },
                        items: actions.map((action) {
                          return DropdownMenuItem(
                            child: Text(action.permission),
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
                initialData: List<FinanceAction>(),
                child: Consumer<List<FinanceAction>>(
                  builder: (_, actions, child) {
                    if (actions.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<FinanceAction>(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Sub actions",
                          enabledBorder: OutlineInputBorder(),
                        ),
                        hint: Text("Select sub action"),
                        value: _provider.selectedSubAction,
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (FinanceAction val) {
                          setState(() {
                            _provider.setSelectedSubAction = val;
                          });
                        },
                        items: actions.map((action) {
                          return DropdownMenuItem(
                            child: Text(action.permission),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: MaterialButton(
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _provider.saveDetails();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FinancePage(),
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
                ),
              )
            ],
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
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Remarks",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.remarks.toString()),
                  ),
                ],
              ),
//              TableRow(
//                decoration: boxDecoration,
//                children: [
//                  Padding(
//                    padding: padding,
//                    child: Text(
//                      "Assigned from",
//                      style: headerText,
//                    ),
//                  ),
//                  Padding(
//                    padding: padding,
//                    child: Text(product.assignedFrom?.name ?? "None"),
//                  ),
//                ],
//              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "AssignedSupplier",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.assignedSupplier.toString()),
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
