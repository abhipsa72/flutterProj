// import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:zel_app/constants.dart';
// import 'package:zel_app/managing_director/managing_director_page.dart';
// import 'package:zel_app/model/selected_dates.dart';
// import 'package:zel_app/store_manager/search.dart';
// import 'package:zel_app/tab_controller.dart';
// import 'package:zel_app/views/aboutDetail.dart';
// import 'package:zel_app/views/profile.dart';
// import 'package:zel_app/warehouse_manager/product/warehouse_manager_page.dart';
// import 'package:zel_app/warehouse_manager/warehouse_manager_provider.dart';
//
// class WarehouseHomePage extends StatefulWidget {
//   static var routeName = "/warehouse_manager";
//
//   @override
//   _WarehouseHomePageState createState() => _WarehouseHomePageState();
// }
//
// class _WarehouseHomePageState extends State<WarehouseHomePage> {
//   SelectedDates _selectedDates = SelectedDates();
//   List<DateTime> selectedDates = List();
//
//   List<Widget> _children = [WarehouseProductPage(), Search()];
//
//   // onTabSelected(int index) {
//   //   setState(() {
//   //     _currentIndex = index;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final _productList = Provider.of<WarehouseManagerProvider>(context);
//     var _provider = Provider.of<TabNotifier>(context);
//     showDatePickerDialog(BuildContext context) async {
//       final List<DateTime> picked = await DateRagePicker.showDatePicker(
//         context: context,
//         initialFirstDate: DateTime.now(),
//         firstDate: DateTime(2015),
//         initialLastDate: (DateTime.now()).add(
//           Duration(days: 7),
//         ),
//         lastDate: DateTime(2025),
//       );
//       if (picked != null && picked.length == 2 && picked != selectedDates) {
//         setState(() {
//           selectedDates = picked;
//           var formatter = DateFormat('dd/MM/yyyy');
//           _selectedDates?.fromDate = formatter.format(picked[0]);
//           _selectedDates?.endDate = formatter.format(picked[1]);
//
//           _productList.setFromAndEndDates(_selectedDates);
//         });
//       }
//     }
//
//     showBottomSheetDialog(BuildContext context) {
//       showModalBottomSheet(
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//           ),
//         ),
//         context: context,
//         builder: (context) {
//           return Wrap(
//             crossAxisAlignment: WrapCrossAlignment.end,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   "Filter",
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//               ),
//               StatefulBuilder(
//                 builder: (_, StateSetter setState) {
//                   return StreamBuilder<List<String>>(
//                     stream: _productList.storeListStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 8),
//                           child: DropdownButtonFormField<String>(
//                             decoration: InputDecoration(
//                               labelText: "Store",
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.always,
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             hint: Text("Select Store"),
//                             value: _productList.selectedStore,
//                             onChanged: (String val) {
//                               setState(() {
//                                 _productList.setSelectedStore = val;
//                                 _productList.getSalesAlarmsyScode();
//                               });
//                             },
//                             items: snapshot.data.map<DropdownMenuItem<String>>(
//                               (alarmAction) {
//                                 return DropdownMenuItem(
//                                   child: Text(alarmAction.toString()),
//                                   value: alarmAction,
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text(snapshot.error.toString()),
//                         );
//                       } else {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               StatefulBuilder(
//                 builder: (_, StateSetter setState) {
//                   return StreamBuilder<List<String>>(
//                     stream: _productList.departmentListStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           child: DropdownButtonFormField<String>(
//                             decoration: InputDecoration(
//                               labelText: "Department",
//                               floatingLabelBehavior:
//                                   FloatingLabelBehavior.always,
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             hint: Text("Select Department"),
//                             value: _productList.selectedDepartment,
//                             onChanged: (String val) {
//                               setState(() {
//                                 _productList.setSelectedDepartment = val;
//                                 _productList.getSalesAlarmsByDept();
//                               });
//                             },
//                             items: snapshot.data.map(
//                               (department) {
//                                 return DropdownMenuItem(
//                                   child: Text(department),
//                                   value: department,
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text(snapshot.error.toString()),
//                         );
//                       } else {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//                 child: MaterialButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     _productList.getFilterList();
//                   },
//                   child: Text("Save"),
//                   color: Theme.of(context).accentColor,
//                   padding: const EdgeInsets.all(16.0),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     return ValueListenableBuilder(
//       valueListenable: Hive.box(userDetailsBox).listenable(),
//       builder: (_, Box box, __) {
//         String token = box.get(authTokenBoxKey);
//         String id = box.get(companyIdBoxKey);
//         String name = box.get(userNameBoxKey);
//         String store = box.get(userStoreKey);
//
//         _productList.setAuthTokenAndCompanyId(token, id);
//
//         return DefaultTabController(
//           length: 2,
//           initialIndex: 1,
//           child: Scaffold(
//             drawer: Drawer(
//               child: ListView(
//                 children: <Widget>[
//                   UserAccountsDrawerHeader(
//                     decoration:
//                         BoxDecoration(color: Theme.of(context).canvasColor),
//                     accountName: Text(
//                       name.toString(),
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                     accountEmail: Text(
//                       store.toString(),
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                     currentAccountPicture: CircleAvatar(
//                       backgroundColor: Theme.of(context).canvasColor,
//                       child: Image.asset(
//                         "assets/zedeye_logo.png",
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.account_circle_outlined),
//                     title: Text("Profile"),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => ProfilePage()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.info),
//                     title: Text("About"),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => AboutPage()),
//                       );
//                     },
//                   ),
//                   ListTile(
//                       title: Text("Logout"),
//                       onTap: () {
//                         logout(context);
//                       },
//                       leading: Icon(Icons.exit_to_app)),
//                 ],
//               ),
//             ),
//             appBar: AppBar(
//               title: Text("Warehouse manager"),
//               actions: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.filter_list),
//                   onPressed: () {
//                     showBottomSheetDialog(context);
//                   },
//                 ),
//               ],
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 showDatePickerDialog(context);
//               },
//               child: Icon(Icons.date_range),
//               backgroundColor: Theme.of(context).accentColor,
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               //type: BottomNavigationBarType.fixed,
//               onTap: (index) {
//                 _provider.currentIndex = index;
//               },
//               currentIndex: _provider.currentIndex,
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.list),
//                   title: Text("Products"),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.search),
//                   title: Text("Search"),
//                 ),
//               ],
//             ),
//             body: _children[_provider.currentIndex],
//           ),
//         );
//       },
//     );
//   }
// }
