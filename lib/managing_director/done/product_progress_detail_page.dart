import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/wip_products.dart';

class MDProductProcessDetailsPage extends StatelessWidget {
  final WiProduct _product;

  MDProductProcessDetailsPage(this._product);

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
            ProductTable(_provider.progressStream),
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

    return StreamBuilder<WiProduct>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          WiProduct product = snapshot.data;
          return Table(
            children: [
                            TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "product code",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.productCode.toString()),
                  ),
                ],
              ),

              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Pending with",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.currentRole.toString()),
                  ),
                ],
              ),


              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "no. of days",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.days.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "supplier",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.assignedSupplier.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "store name",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.storeName.toString()),
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

  final Stream<WiProduct> _product;

  ProductTable(this._product);
}
