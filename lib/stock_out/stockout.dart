import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/model/stock_out/subgroup_stockout_model.dart';
import 'package:zel_app/stock_out/stock_out_provider.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';

class StackOut extends StatefulWidget {
  static var routeName = "/stockOut";
  @override
  _StackOutState createState() => _StackOutState();
}

class _StackOutState extends State<StackOut> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<StockOutProvider>(context);
    String _dropDownValue;

    PersistentBottomSheetController _controller;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    String _selectedDate;
    DateTime selectedDate;

    showDatePickerDialog(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
          var formatter = DateFormat('yyyy-MM-dd');
          _selectedDate = formatter.format(picked);
          _provider.setFromAndEndDates(_selectedDate);
        });
      }
    }

    Column subgroupSummary(
      List<Store> stores,
      StockOutProvider _provider,
      BuildContext context,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'SubGroup summary ',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stores.length,
            itemBuilder: (_, index) {
              Store store = stores[index];
              return Container(
                  margin: EdgeInsets.all(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Card(
                        child: ExpansionTile(
                            title: Text(
                              "Store name:  " + store.store,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: store.subgroup
                                .map((bin) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ListTile(
                                          title: Text(bin.subgroup),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 5),
                                              Text("Number of subgroups: " +
                                                  bin.noOfSubgroup.toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList())),
                  ));
            },
          ),
        ],
      );
    }

    // Column productSummary(
    //   List<StoreName> stores,
    //   StockOutProvider _provider,
    //   BuildContext context,
    // ) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       Center(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             'Product summary ',
    //             style: TextStyle(
    //               fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ),
    //       ListView.builder(
    //         physics: const NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         itemCount: stores.length,
    //         itemBuilder: (_, index) {
    //           StoreName store = stores[index];
    //           return Container(
    //               margin: EdgeInsets.all(6),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 5),
    //                 child: Card(
    //                     child: ExpansionTile(
    //                         title: Text(
    //                           "Store name:  " + store.store,
    //                           style: TextStyle(
    //                               color: Colors.blue,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                         children: <Widget>[
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.stretch,
    //                         children: [
    //                           ListTile(
    //                             title: Text(store.data.flagDataNo.flag),
    //                             subtitle: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 const SizedBox(height: 5),
    //                                 Text("Number of products: " +
    //                                     store.data.flagDataNo.noOfProducts
    //                                         .toString()),
    //                                 Text("Number of pending pos: " +
    //                                     store.data.flagDataNo.noOfPendingPos
    //                                         .toString()),
    //                               ],
    //                             ),
    //                           ),
    //                           ListTile(
    //                             title: Text(store.data.flagDataYes.flag),
    //                             subtitle: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 const SizedBox(height: 5),
    //                                 Text("Number of products: " +
    //                                     store.data.flagDataYes.noOfProducts
    //                                         .toString()),
    //                                 Text("Number of pending pending pos: " +
    //                                     store.data.flagDataYes.noOfPendingPos
    //                                         .toString()),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ])),
    //               ));
    //         },
    //       ),
    //     ],
    //   );
    // }

    showBottomSheetDialog(BuildContext context) {
      //_provider.getRegion();
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
              // StatefulBuilder(
              //   builder: (_, StateSetter setState) {
              //     return StreamBuilder<List<String>>(
              //       stream: _provider.regionStream,
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData) {
              //           // List<Store> products = snapshot.data;
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 16, vertical: 8),
              //             child: DropdownButtonFormField<String>(
              //               decoration: InputDecoration(
              //                 labelText: "Region",
              //                 floatingLabelBehavior:
              //                     FloatingLabelBehavior.always,
              //                 enabledBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //               ),
              //               hint: Text("Select Region"),
              //               value: _provider.selectedRegion,
              //               onChanged: (String val) {
              //                 setState(() {
              //                   print(_provider.selectedRegion);
              //                   _provider.setSelectedRegion = val;
              //                   _provider.setStoreToNull();
              //                   _provider.stores(val);
              //                 });
              //               },
              //               items: snapshot.data.map<DropdownMenuItem<String>>(
              //                 (alarmAction) {
              //                   return DropdownMenuItem(
              //                     child: Text(alarmAction.toString()),
              //                     value: alarmAction,
              //                   );
              //                 },
              //               ).toList(),
              //             ),
              //           );
              //         } else if (snapshot.hasError) {
              //           return Center(
              //             child: Text(snapshot.error.toString()),
              //           );
              //         } else {
              //           print("problem");
              //           return Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         }
              //       },
              //     );
              //   },
              // ),
              Divider(
                height: 50,
                indent: 16,
                endIndent: 16,
              ),
              StatefulBuilder(
                builder: (_, StateSetter setState) {
                  return StreamBuilder<List<String>>(
                    stream: _provider.subGroupStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        // List<Store> products = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Stores",
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
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        print("problem");
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

                    //_provider.productSummary();
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

    return ValueListenableBuilder(
      valueListenable: Hive.box(userDetailsBox).listenable(),
      builder: (BuildContext context, Box box, Widget child) {
        String token = box.get(authTokenBoxKey);
        String name = box.get(userNameBoxKey);
        String store = box.get(userStoreKey);
        _provider.setAuthTokenAndCompanyId(token);
        return Scaffold(
          appBar: AppBar(
            title: Text("Stack out"),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showBottomSheetDialog(context);
                },
              ),
            ],
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDatePickerDialog(context);
            },
            child: Icon(Icons.date_range),
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Consumer<StockOutProvider>(
                  builder: (_, dates, child) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "From ${dates.selectedDate} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Product summary ',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.subtitle1.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Text(
                    "stor name: 0201",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("id : 613b4c769fde0c2c75a598e"),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.1, 0.0, 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text("noofsku  : 100.0"),
                            Text("oossku :25.0"),
                            Text("date : 09/10/202"),
                            Text("dept : Fresh")
                          ]),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "stor name: 0201",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("id : 613b4c859fde0c2c75a598e5"),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.1, 0.0, 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text("noofsku  : 100.0"),
                            Text("oossku :25.0"),
                            Text("date : 09/10/202"),
                            Text("dept : FMCG")
                          ]),
                    )
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "stor name: 0201",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("id : 613b4c7c9fde0c2c75a598e4"),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 0.1, 0.0, 10.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text("noofsku  : 100.0"),
                            Text("oossku :25.0"),
                            Text("date : 09/10/202"),
                            Text("dept : LHH")
                          ]),
                    )
                  ],
                )
                // ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                // itemCount: stores.length,
                // itemBuilder: (_, index) {
                //
                // return Container(
                // margin: EdgeInsets.all(6),
                // child: Padding(
                // padding: const EdgeInsets.symmetric(vertical: 5),
                // child: Card(
                // child: ExpansionTile(
                // title: Text(
                // "Store name:  " + "0201",
                // style: TextStyle(
                // color: Colors.blue,
                // fontWeight: FontWeight.bold),
                // ),
                // children: <Widget>[
                // Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                // children: [
                // ListTile(
                // title: Text(store.data.flagDataNo.flag),
                // subtitle: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                // const SizedBox(height: 5),
                // Text("Number of products: " +
                // store.data.flagDataNo.noOfProducts
                //     .toString()),
                // Text("Number of pending pos: " +
                // store.data.flagDataNo.noOfPendingPos
                //     .toString()),
                // ],
                // ),
                // ),
                // ListTile(
                // title: Text(store.data.flagDataYes.flag),
                // subtitle: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                // const SizedBox(height: 5),
                // Text("Number of products: " +
                // store.data.flagDataYes.noOfProducts
                //     .toString()),
                // Text("Number of pending pending pos: " +
                // store.data.flagDataYes.noOfPendingPos
                //     .toString()),
                // ],
                // ),
                // ),
                // ],
                // ),
                // ])),
                // ));
                // },
                // );
              ],
            ),
          ),
        );
      },
    );
  }
}
