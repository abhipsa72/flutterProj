import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/store_product.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/store_manager/product/product_status_detail.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class ProductStatusWIP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
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
            StreamBuilder<List<StoreProduct>>(
              stream: _provider.filterAlamListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<StoreProduct> products = snapshot.data;
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
                      StoreProduct product = products[index];
                      return ListTile(
                        title: Text(product.description),
                        subtitle: Text(product.category),
                        trailing:
                            Text(departmentValues.reverse[product.department]),
                        onTap: () async {
                          _provider.setProductAlam = product;

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductStatusDetail(),
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

class ProductStatusComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
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
            StreamBuilder<List<StoreProduct>>(
              stream: _provider.filterAlamListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<StoreProduct> products = snapshot.data;
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
                      StoreProduct product = products[index];
                      return ListTile(
                        title: Text(product.description),
                        subtitle: Text(product.category),
                        trailing:
                            Text(departmentValues.reverse[product.department]),
                        onTap: () async {
                          _provider.setProductAlam = product;

                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductStatusDetail(),
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
