import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:zel_app/store_manager/actions_done/action_done_bloc.dart';
import 'package:zel_app/store_manager/home/home_page.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';
import 'package:zel_app/store_manager/product/product_list_page.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/store_manager/search.dart';
import 'package:zel_app/util/enum_values.dart';
import 'package:zel_app/views/NoInternet.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';

class StoreManagerPage extends StatefulWidget {
  static String routeName = "/home_page";

  @override
  _StoreManagerPageState createState() => _StoreManagerPageState();
}

class _StoreManagerPageState extends State<StoreManagerPage> {
  SelectedDates _selectedDates = SelectedDates();
  List<DateTime> selectedDates = List();
  int _currentIndex = 0;
  List<Widget> _children = [
    HomePage(),
    ProductListPage(),
    ActionListPage(),
    Search()
  ];

  onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _chartProvider = Provider.of<ChartsProvider>(context);
    final _productList = Provider.of<ProductListingProvider>(context);

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

          _chartProvider.setFromAndEndDate(_selectedDates);
          _productList.setFromAndEndDate(_selectedDates);
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

        _chartProvider.setAuthTokenAndCompanyId(token, id);
        _productList.setAuthTokenAndCompanyId(token, id);
        return Consumer<ConnectivityStatus>(builder: (_, value, child) {
          if (value == ConnectivityStatus.Offline) {
            return NoInternet();
          }
          return DefaultTabController(
            length: 4,
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
              appBar: AppBar(title: Text("Store manager"), actions: <Widget>[]),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTabSelected,
                currentIndex: _currentIndex,
                showSelectedLabels: true,
                showUnselectedLabels: true,
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
                    icon: Icon(Icons.redo),
                    title: Text("Re-Assigned"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    title: Text("Search"),
                  ),
                ],
              ),
              body: _children[_currentIndex],
            ),
          );
        });
      },
    );
  }
}
