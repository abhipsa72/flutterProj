import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_product_detail.dart';
import 'package:zel_app/warehouse_manager/warehouse_manager_provider.dart';

class ProductProgressDetail extends StatefulWidget {
  @override
  _ProductStatusState createState() =>
      _ProductStatusState();
}
class _ProductStatusState extends State<ProductProgressDetail> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<WarehouseManagerProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Details page"),
          bottom: PreferredSize(
            child: ToolbarProgress(_provider.isLoadingStream),
            preferredSize: Size(double.infinity, 2.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ProductTable(_provider.productStream),
              ],
            ),
          ),
        )
    );
  }
}