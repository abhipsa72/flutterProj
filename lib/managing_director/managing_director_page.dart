import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/managers/repository.dart';
import 'package:zel_app/managing_director/done/product_progress_list_page.dart';
import 'package:zel_app/managing_director/home/managing_director.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/managing_director/products/product_list_page.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/store_manager/product/product_details_page.dart';
import 'package:zel_app/util/ExceptionHandle.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';

class ManagingDirectorPage extends StatefulWidget {
  static String routeName = "/md_page";

  @override
  _ManagingDirectorState createState() => _ManagingDirectorState();
}

class _ManagingDirectorState extends State<ManagingDirectorPage> {
  SelectedDates _selectedDates = SelectedDates();
  List<DateTime> selectedDates = List();
  DataManagerRepository _repository;
  int _currentIndex = 0;
  List<Widget> _children = [
    ManagingDirectorChart(),
    MDProductListPage(),
    MDProductProcessListPage(),
  ];

  // onTabSelected(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ManagingDirectorProvider>(context);
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
          _selectedDates?.fromDate = formatter.format(picked[0]);
          _selectedDates?.endDate = formatter.format(picked[1]);

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
        String name = box.get(userNameBoxKey);
        String email = box.get(userEmailBoxKey);
        String store = box.get(userStoreKey);
        return DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDatePickerDialog(context);
                },
                child: Icon(Icons.date_range),
                backgroundColor: Theme.of(context).accentColor,
              ),
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
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
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
                title: Text("Managing Director"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      showBottomSheetDialog(context, _provider);
                    },
                  ),
                ],
                bottom: PreferredSize(
                  child: ToolbarProgress(_provider.isLoadingStream),
                  preferredSize: Size(double.infinity, 2.0),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  _provider.currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    title: Text("Products"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    title: Text("Max Delay UA"),
                  ),
                ],
                currentIndex: _provider.currentIndex,
              ),
              body: _children[_provider.currentIndex]),
        );
      },
    );
  }
}

void logout(BuildContext context) {
  Hive.openBox(userDetailsBox).then((value) {
    value.clear().then((value) => Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (route) => false));
  });
}

showBottomSheetDialog(
  BuildContext context,
  ManagingDirectorProvider _provider,
) {
  _provider.getAllRoles();
  _provider.getAllRegion();
//_provider.getStore(region)
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
                stream: _provider.regionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Region",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Region"),
                        value: _provider.selectedRegion,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedRegion = val;
                            _provider.setApiState = ApiState.WithRegion;
                            _provider.setStoreToNull();
                            _provider.getStore(val);
                            _provider.refreshChart();
                            _provider.refreshProductRegion();
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          Divider(
            height: 50,
            indent: 16,
            endIndent: 16,
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.storeListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Store",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Store"),
                        value: _provider.selectedStore,
                        onChanged: (String val) {
                          setState(() {
                            _provider.setSelectedStore = val;
                            _provider.setApiState = ApiState.WithStore;
                            _provider.refreshChart();
                            _provider.refreshProductStore();
                          });
                        },
                        isExpanded: true,
                        isDense: true,
                        selectedItemBuilder: (BuildContext context) {
                          return snapshot.data.map<Widget>((text) {
                            return Text(
                              text,
                              overflow: TextOverflow.ellipsis,
                            );
                          }).toList();
                        },
                        items: snapshot.data.map((storeCode) {
                          return DropdownMenuItem(
                            child: Text(
                              storeCode,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: storeCode,
                          );
                        }).toList(),
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.rolesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Role",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Role"),
                        value: _provider.selectedRole,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedRole = val;
                            _provider.getWorkInProgressAlarmsByRole();
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                //_provider.getFilterList();
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
