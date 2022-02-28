import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/repeat_refresh.dart';

class MDProductDetailsRefreshPage extends StatelessWidget {
  final RepeatRefresh _product;

  MDProductDetailsRefreshPage(this._product);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ManagingDirectorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProductTable(_provider.productRefreshStream),
          ],
        ),
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);

    return StreamBuilder<RepeatRefresh>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          RepeatRefresh product = snapshot.data;
          return Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Product",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.description.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Department",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.department),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "sub_group",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.subCategory.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "frequency",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.count.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "stores",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.store.toString()),
                  ),
                ],
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }

  final Stream<RepeatRefresh> _product;

  ProductTable(this._product);
}
