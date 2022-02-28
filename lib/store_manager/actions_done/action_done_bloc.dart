import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/store_manager/actions_done/action_detail_page.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class ActionListPage extends StatelessWidget {
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
            StreamBuilder<List<ActionDone>>(
              stream: _provider.actionListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<ActionDone> products = snapshot.data;
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
                      ActionDone product = products[index];
                      return ListTile(
                        title: Text(product.description),
                        subtitle: Text(product.category),
//                        trailing:
//                        Text(departmentValues.reverse[product.department]),
                        onTap: () async {
                          _provider.setActionDone = product;
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  StoreActionDetailsPage(product),
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
