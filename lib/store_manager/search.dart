import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/search.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);
    Column searchResult(
      List<AlarmStat> stores,
      BuildContext context,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Product summary ',
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
              AlarmStat store = stores[index];
              return Container(
                  margin: EdgeInsets.all(6),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        child: ExpansionTile(
                            title: Text(
                              store.description,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 6),
                                Text("Current status: " +
                                    store.currentPendingWith.toString()),
                                // const SizedBox(height: 6),
                                // Text("Remark sales % : " +
                                //     prod.remarkLevelSalesPercentage
                                //         .toString()),
                              ],
                            ),
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    title: Text("prod Id:" +
                                        store.productCode.toString()),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Text("Issued Date:  " +
                                            DateFormat('dd/MM/yyyy ')
                                                .format(store.date)),
                                        Text("Action:  " + store.action),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      )));
            },
          ),
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Consumer<ProductListingProvider>(
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
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // controller: _numberController,
                    maxLines: 1,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[1-9][.0-9]*$')),
                    ],
                    // onChanged: _provider.numberOfTargetDays,
                    onChanged: _provider.prodId,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Enter product id",
                      //labelText: "Target days",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Divider(
              height: 22,
              endIndent: 16,
              indent: 16,
            ),
            Center(
              child: MaterialButton(
                padding: const EdgeInsets.all(16.0),
                onPressed: () {
                  _provider.search();
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Search",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              height: 32,
              endIndent: 16,
              indent: 16,
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: <Widget>[
            //     ListView.builder(
            //       physics: const NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: remarks.length,
            //       itemBuilder: (_, index) {
            //         Product prod = remarks[index];
            StreamBuilder<List<AlarmStat>>(
              stream: _provider.searchStateStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<AlarmStat> alaramState = snapshot.data;
                  if (alaramState.isEmpty || alaramState == null) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Store not found ..."),
                          ),
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
                            searchResult(alaramState, context)
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
                          // CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("No Data"),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            // Container(
            //     margin: EdgeInsets.all(6),
            //     child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 5),
            //         child: Card(
            //           child: ExpansionTile(
            //               title: Text(
            //                 "Jordan KGS ",
            //                 style: TextStyle(
            //                     color: Colors.blue,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //               subtitle: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   const SizedBox(height: 6),
            //                   Text("Current status: " + "wip"),
            //                   // const SizedBox(height: 6),
            //                   // Text("Remark sales % : " +
            //                   //     prod.remarkLevelSalesPercentage
            //                   //         .toString()),
            //                 ],
            //               ),
            //               children: <Widget>[
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     ListTile(
            //                       title: Text("prod code:"),
            //                       subtitle: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           const SizedBox(height: 5),
            //                           Text("Date of issue: "),
            //                           Text("Initial issue: "),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ]),
            //         )))
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
