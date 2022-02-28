import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/purchaser/purchaser_page_provider.dart';

class PurchaserDetailsPage extends StatelessWidget {
  final ActionDone _product;

  PurchaserDetailsPage(this._product);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<PurchaserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ActionTable(_provider.actionStream),
          ],
        ),
      ),
    );
  }
}

class ActionTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);

    return StreamBuilder<ActionDone>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          ActionDone product = snapshot.data;
          return Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      " assigned supplier",
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
                      "ProductCode",
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
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "category",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.category.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "store stock",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.storeStock.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "warehouse stock",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.warehouseStock.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "action",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.action.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "final permission",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(product.finalWorkflowPermission.toString()),
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

  final Stream<ActionDone> _product;

  ActionTable(this._product);
}
