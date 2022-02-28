import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/product.dart';
import 'package:zel_app/purchaser/purchaser_page_provider.dart';
import 'package:zel_app/purchaser/purchaser_status_detail.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class PurchaserStatusWIP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBar(
              title: Text("WIP"),
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
                  if (products.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("No data")),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      Product product = products[index];
                      return ListTile(
                        title: Text(product.description),
                        subtitle: Text(product.category),
                        trailing:
                            Text(departmentValue.reverse[product.department]),
                        onTap: () async {
                          _provider.setProduct = product;

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PurchaserStatusDetail(),
                            ),
                          );
                        },
                      );
                    },
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
}

class PurchaserStatusComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBar(
              title: Text("Completed"),
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
                  if (products.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("No data")),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      Product product = products[index];
                      return ListTile(
                        title: Text(product.description),
                        subtitle: Text(product.category),
                        trailing:
                            Text(departmentValue.reverse[product.department]),
                        onTap: () async {
                          _provider.setProduct = product;

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PurchaserStatusDetail(),
                            ),
                          );
                        },
                      );
                    },
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
}
