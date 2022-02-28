import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/Department/department.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/rca/store/store_detail.dart';
import 'package:zel_app/rca/store/store_model.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    String _dropDownValue;
    List<Store> sortt;
    PersistentBottomSheetController _controller;
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    showBottomSheetDialog(BuildContext context) {}

    Column showProducts(
      List<Store> stores,
      RCAProvider _provider,
      BuildContext context,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stores.length,
            itemBuilder: (_, index) {
              Store store = stores[index];
              final formatter = new NumberFormat("#,###");

              return Container(
                  margin: EdgeInsets.all(2),
                  child: ListTile(
                    title: Text(store.store),
                    subtitle: Text(
                      "Loss percentage :  " +
                          store.lossesPercentage.toString() +
                          "%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: store.lossesPercentage >= 25
                            ? Colors.redAccent
                            : store.lossesPercentage >= 20 &&
                                    store.lossesPercentage < 25
                                ? Colors.yellow[900]
                                : store.lossesPercentage >= 10 &&
                                        store.lossesPercentage < 20
                                    ? Colors.yellow[700]
                                    : store.lossesPercentage >= 5 &&
                                            store.lossesPercentage < 10
                                        ? Colors.green[300]
                                        : Colors.green[700],
                      ),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        color: Colors.blueAccent,
                        onPressed: () => {
                              _provider.setStore = store,
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StoreDetailsPage(),
                                ),
                              )
                            }),
                    onTap: () {
                      _provider.getDepartment(store.storeId.toString());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              DepartmentPage(store.storeId.toString()),
                        ),
                      );
                    },
                  ));
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Store>>(
              stream: _provider.storeListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Store> store = snapshot.data;
                  store.sort((a, b) =>
                      a.lossesPercentage.compareTo(b.lossesPercentage));
                  //print(store..b);
                  if (store.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading stores..."),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            showProducts(store, _provider, context)
                          ]));
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
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Loading stores..."),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }
}
