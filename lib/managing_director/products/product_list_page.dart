import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/managing_director/products/product-detail_refresh.dart';
import 'package:zel_app/managing_director/products/product_details_page.dart';
import 'package:zel_app/model/repeat_refresh.dart';
import 'package:zel_app/model/sale_product.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class MDProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ManagingDirectorProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Repeat Product Table",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Consumer<ManagingDirectorProvider>(
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
            Divider(
              height: 32,
              endIndent: 16,
              indent: 16,
            ),
            _provider.apiState == ApiState.WithRegion
                ? StreamBuilder<List<SaleProduct>>(
                    stream: _provider.salesProductsListStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<SaleProduct> products = snapshot.data;
                        // child: Consumer<List<SaleProduct>>(
                        //   builder: (_, products, child) {
                        if (products.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text("No data"),
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            SaleProduct product = products[index];
                            return ListTile(
                              title: Text(product.product),
                              onTap: () {
                                _provider.setProduct = product;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MDProductDetailsPage(product)));
                              },
                            );
                          },
                        );
                        // },
                        // ),
                        //   ),
                        // ]
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
                  )
                : StreamBuilder<List<RepeatRefresh>>(
                    stream: _provider.productListRefreshStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<RepeatRefresh> products = snapshot.data;
                        // child: Consumer<List<SaleProduct>>(
                        //   builder: (_, products, child) {
                        if (products.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text("No data"),
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (_, index) {
                            RepeatRefresh product = products[index];
                            return ListTile(
                              title: Text(product.description),
                              onTap: () {
                                _provider.setRefresh = product;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MDProductDetailsRefreshPage(product)));
                              },
                            );
                          },
                        );
                        // },
                        // ),
                        //   ),
                        // ]
                      } else if (snapshot.hasError) {
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
                  )
          ]),
    ));
  }
}
