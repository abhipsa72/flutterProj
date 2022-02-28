import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/purchaser/purchaser_page_provider.dart';
import 'package:zel_app/purchaser/purchaser_product_detail.dart';
import 'package:zel_app/purchaser/purchaser_status_page.dart';
import 'package:zel_app/util/ExceptionHandle.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';
import 'package:zel_app/views/status_card.dart';

class PurchaserPage extends StatefulWidget {
  static var routeName = "/purchaser_page";
  @override
  _PurchaserHomePageState createState() => _PurchaserHomePageState();
}

class _PurchaserHomePageState extends State<PurchaserPage> {
  List<DateTime> selectedDates = List();
  SelectedDates _selectedDates = SelectedDates();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);

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
                                _provider.getSalesAlarmsyScode();
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
                        return Center(
                          heightFactor: 30,
                          child: Text(
                            dioError(snapshot.error),
                            textAlign: TextAlign.center,
                          ),
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
                                _provider.getSalesAlarmsByDept();
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
        String name = box.get(userNameBoxKey);
        String store = box.get(userStoreKey);
        _provider.setAuthTokenAndCompanyId(token, id);
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).canvasColor),
                  accountName: Text(
                    name.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  accountEmail: Text(
                    store.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).canvasColor,
                    child: Image.asset(
                      "assets/zedeye_logo.png",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text("Profile"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                ListTile(
                    title: Text("Logout"),
                    onTap: () {
                      logout(context);
                    },
                    leading: Icon(Icons.exit_to_app)),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Purchaser"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showBottomSheetDialog(context);
                },
              ),
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
                      return PurchaserAlarmStatus(details);
                    } else if (snapshot.hasError) {
                      return Center(
                        heightFactor: 30,
                        child: Text(
                          dioError(snapshot.error),
                          textAlign: TextAlign.center,
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
                      return Center(
                        heightFactor: 30,
                        child: Text(
                          dioError(snapshot.error),
                          textAlign: TextAlign.center,
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
    PurchaserProvider _provider,
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
                _provider.setSupplierToNull();
                _provider.setActionToNull();
                _provider.setSubActionToNull();
                _provider.setAsignToNull();
                _provider.setProduct = product;

                _provider.getPermissionsByRole();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PurchaserProductDetails(),
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

class PurchaserAlarmStatus extends StatelessWidget {
  final AlarmDetailsResponse response;

  PurchaserAlarmStatus(this.response);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Consumer<PurchaserProvider>(
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
                        builder: (context) => PurchaserStatusComplete(),
                      ),
                    );
                    _provider.purchaserProductList();
                  },
                  child: StatusCard(
                    Icons.alarm,
                    Colors.pinkAccent[100],
                    "Alarm completed",
                    response.comp.toString(),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    _provider.filterAlaram("WIP");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PurchaserStatusWIP(),
                      ),
                    );
                    _provider.purchaserProductList();
                  },
                  child: StatusCard(
                    Icons.alarm,
                    Colors.lightGreenAccent,
                    "Alarm Work In Progress",
                    response.wip.toString(),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _provider.filterAlaram("UA"),
                  child: StatusCard(
                    Icons.alarm,
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
