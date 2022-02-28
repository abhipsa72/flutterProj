import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/products/rca_bar.dart';
import 'package:zel_app/rca/products/rca_bar_model.dart';
import 'package:zel_app/rca/products/remark_model.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class ProductRca extends StatefulWidget {
  final storeId;
  ProductRca(this.storeId);
  @override
  _ProductRcaState createState() => _ProductRcaState(storeId);
}

class _ProductRcaState extends State<ProductRca> {
  final storeId;

  _ProductRcaState(this.storeId);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    String _dropDownValue;

    PersistentBottomSheetController _controller;
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    Column showProducts(
      List<Product> remarks,
      RCAProvider _provider,
      BuildContext context,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: remarks.length,
            itemBuilder: (_, index) {
              Product prod = remarks[index];

              return Container(
                  margin: EdgeInsets.all(6),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        child: ExpansionTile(
                          title: Text(
                            "remark:  " + prod.remark,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text("Number of Products: " +
                                  prod.numberOfProducts.toString()),
                              const SizedBox(height: 6),
                              Text("Remark sales % : " +
                                  prod.remarkLevelSalesPercentage.toString()),
                            ],
                          ),
                          children: prod.bins
                              .map((bin) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Row(
                                      //   children: [Text("Bin:"), Text(bin.bin)],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text("Some percentage:"),
                                      //     Text(bin.binLevelSalesPercentage)
                                      //   ],
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text("Some other percentage:"),
                                      //     Text(bin.numberOfBinProducts.toString())
                                      //   ],
                                      // ),
                                      ListTile(
                                        title: Text(bin.bin),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text("Number of bin Products: " +
                                                bin.numberOfBinProducts
                                                    .toString()),
                                            const SizedBox(height: 4),
                                            Text("Bin sales % : " +
                                                bin.binLevelSalesPercentage
                                                    .toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                      )));
            },
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Product>>(
              stream: _provider.remarkListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Product> remark = snapshot.data;
                  if (remark.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading ..."),
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
                            showProducts(remark, _provider, context)
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
                            child: Text("Loading..."),
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
            StreamBuilder<List<Result>>(
              stream: _provider.barChartStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Result> remark = snapshot.data;

                  if (remark.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading ..."),
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
                          children: <Widget>[RcaBarChart(remark)]));
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
                            child: Text("Loading..."),
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
  }
}
