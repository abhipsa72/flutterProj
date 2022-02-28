import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/IT/it_product_detail.dart';
import 'package:zel_app/IT/it_progress.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:zel_app/views/status_card.dart';
import 'it_provider.dart';

class ItProductPage extends StatefulWidget {
  static var routeName = "/it_page";
  @override
  _ItProductPageState createState() => _ItProductPageState();
}

class _ItProductPageState extends State<ItProductPage> {
  // ignore: deprecated_member_use
  List<DateTime> selectedDates = List();
  SelectedDates _selectedDates = SelectedDates();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ItProvider>(context);

    showBottomSheetDialog(BuildContext context) {
      showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) {
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Filter",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              StatefulBuilder(
                builder: (_, StateSetter setState) {
                  return StreamBuilder<List<String>>(
                    stream: _provider.storeListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isEmpty) {
                          return Center(
                            child: Text("No stores found"),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Store",
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            hint: Text("Select Store"),
                            value: _provider.selectedStore,
                            onChanged: (String val) {
                              setState(() {
                                _provider.setSelectedStore = val;
                              });
                            },
                            items: snapshot.data.map<DropdownMenuItem<String>>(
                                  (alarmAction) {
                                return DropdownMenuItem(
                                  child: Text(alarmAction.toString()),
                                  value: alarmAction,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(snapshot.error.toString());
                        return Center(
                          child: Text("Unable to load stores"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              StatefulBuilder(
                builder: (_, StateSetter setState) {
                  return StreamBuilder<List<String>>(
                    stream: _provider.departmentListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isEmpty) {
                          return Center(
                            child: Text("No departments found"),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Department",
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            hint: Text("Select Department"),
                            value: _provider.selectedDepartment,
                            onChanged: (String val) {
                              setState(() {
                                _provider.setSelectedDepartment = val;
                              });
                            },
                            items: snapshot.data.map(
                                  (department) {
                                return DropdownMenuItem(
                                  child: Text(department),
                                  value: department,
                                );
                              },
                            ).toList(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(snapshot.error.toString());
                        return Center(
                          child: Text("Unable to load departments"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _provider.getFilterList();
                  },
                  child: Text("Save"),
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
            ],
          );
        },
      );
    }

    showDatePickerDialog(BuildContext context) async {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        firstDate: DateTime(2015),
        initialLastDate: (DateTime.now()).add(
          Duration(days: 7),
        ),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked.length == 2 && picked != selectedDates) {
        setState(() {
          selectedDates = picked;
          var formatter = DateFormat('dd/MM/yyyy');
          _selectedDates.fromDate = formatter.format(picked[0]);
          _selectedDates.endDate = formatter.format(picked[1]);
          _provider.setFromAndEndDates(_selectedDates);
        });
      }
    }

    return ValueListenableBuilder(
      valueListenable: Hive.box(userDetailsBox).listenable(),
      builder: (_, Box box, __) {
        String token = box.get(authTokenBoxKey);
        String id = box.get(companyIdBoxKey);
        _provider.setAuthTokenAndCompanyId(token, id);
        return Scaffold(
          appBar: AppBar(
            title: Text("IT"),
            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.filter_list),
//                onPressed: () {
//                  showBottomSheetDialog(context);
//                },
//              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Hive.openBox(userDetailsBox).then(
                        (value) {
                      value.clear().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginPage.routeName, (route) => false));
                    },
                  );
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDatePickerDialog(context);
            },
            child: Icon(Icons.date_range),
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<AlarmDetailsResponse>(
                  stream: _provider.alarmDetailStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      AlarmDetailsResponse details = snapshot.data;
                      return ItAlarmStatus(details);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(snapshot.error.toString()),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                Divider(
                  height: 32,
                  endIndent: 16,
                  indent: 16,
                ),
                StreamBuilder<List<Product>>(
                  stream: _provider.productListStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> products = snapshot.data;
                      return showProducts(products, _provider, context);
                    } else if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Loading products..."),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column showProducts(
      List<Product> products,
      ItProvider _provider,
      BuildContext context,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (_, index) {
            Product product = products[index];
            return ListTile(
              title: Text(product.description),
              subtitle: Text(product.category),
              trailing: Text(
                departmentValue.reverse[product.department],
              ),
              onTap: () {

                _provider.setActionToNull();

                _provider.setProduct = product;
//                _provider.setSupplierToNull();

//                _provider.setSubActionToNull();
                _provider.getPermissionsByRole();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ItProductDetails(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
class ItAlarmStatus extends StatelessWidget {
  final AlarmDetailsResponse response;

  ItAlarmStatus(this.response);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ItProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Consumer<ItProvider>(
          builder: (_, dates, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "From ${dates.selectedDates?.fromDate} - To ${dates.selectedDates?.endDate}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        Container(
          height: 166,
          width: 170,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                 // onTap: ()=> _provider.filterAlaram("COMPLETED") ,
                  onTap: () async {
                    _provider.filterAlaram("COMPLETED");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItProgressComplete(),
                      ),
                    );
                    _provider.itProductList();
                  },
                  child: StatusCard(
                    Icons.battery_full,
                    Colors.pinkAccent[100],
                    "Alarm completed",
                    response.comp.toString(),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  //onTap: ()=> _provider.filterAlaram("WIP") ,
                  onTap: () async {
                    _provider.filterAlaram("WIP");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ItProgressWIP(),
                      ),
                    );
                    _provider.itProductList();
                  },
                  child: StatusCard(
                    Icons.battery_charging_full,
                    Colors.lightGreenAccent,
                    "Alarm WIP",
                    response.wip.toString(),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: ()=> _provider.filterAlaram("UA") ,
                  child: StatusCard(
                    Icons.battery_alert,
                    Colors.yellow,
                    "Alarm Unattended",
                    response.ua.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}