import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/done/product_progress_detail_page.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/wip_products.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class MDProductProcessListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ManagingDirectorProvider>(context);

    return StreamBuilder(
        stream: _provider.wipProductsListStream,
        // create: (context) => _provider.wipProductsListStream,
        initialData: null,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            List<WiProduct> products = snapshot.data;
            if (products.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text("No data"),
                ),
              );
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, index) {
                WiProduct product = products[index];
                return ListTile(
                  title: Text(product.description),
                  onTap: () {
                    _provider.setProgress = product;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MDProductProcessDetailsPage(product)));
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
        });
  }
}
