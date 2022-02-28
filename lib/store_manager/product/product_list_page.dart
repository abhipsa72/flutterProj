import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/model/store_product.dart';
import 'package:zel_app/store_manager/product/ProductStatusPage.dart';
import 'package:zel_app/store_manager/product/product_details_page.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/util/dio_network.dart';
import 'package:zel_app/views/status_card.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //List myList;
  //   //List<StoreProduct> products;
  ScrollController _scrollController = ScrollController();
  //int _currentMax = 20;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Consumer<ProductListingProvider>(
              builder: (_, provider, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "From ${provider.selectedDates?.fromDate} - To ${provider.selectedDates?.endDate}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            Divider(
              height: 32,
              endIndent: 16,
              indent: 16,
            ),
            StreamBuilder<List<StoreProduct>>(
              stream: _provider.productListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<StoreProduct> products = snapshot.data;
                  if (products.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("No data")),
                    );
                  }
                  return showProducts(products, _provider, context);
                } else if (snapshot.hasError) {
                  print("a");
                  print(snapshot.error.toString());
                  exitApp(context, snapshot.error);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
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
            SizedBox(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }

  Column showProducts(
    List<StoreProduct> products,
    ProductListingProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Unattended Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (_, index) {
            StoreProduct product = products[index];
            return ListTile(
              title: Text(product.description),
              subtitle: Text(product.category),
              trailing: Text(
                departmentValues.reverse[product.department],
              ),
              onTap: () {
                _provider.setAlaramToNull();
                _provider.setActionToNull();
                _provider.setSubActionToNull();
                _provider.setLevel4OptionToNull();
                _provider.setProduct = product;
                _provider.getAllAlarms();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StoreManagerProductDetails(),
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

class AlarmDetailsPage extends StatelessWidget {
  final AlarmDetailsResponse response;

  AlarmDetailsPage(this.response);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
    return Column(
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
        Container(
          height: 166,
          width: 170,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    _provider.filterStoreAlaram("comp");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductStatusComplete(),
                      ),
                    );
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
                    _provider.filterStoreAlaram("wip");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductStatusWIP(),
                      ),
                    );
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
                  // onTap: () => _provider.filterStoreAlaram("ua"),
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

Future<bool> exitApp(BuildContext context, DioError error) {
  return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: handleError(error),
          content: Text("try again letter"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                logout(context);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}
