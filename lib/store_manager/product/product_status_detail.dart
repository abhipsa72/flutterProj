import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/store_manager/product/product_details_page.dart';
import 'package:zel_app/store_manager/product/product_provider.dart';

class ProductStatusDetail extends StatefulWidget {
  @override
  _ProductStatusState createState() => _ProductStatusState();
}

class _ProductStatusState extends State<ProductStatusDetail> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListingProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Details page"),
          bottom: PreferredSize(
            child: ToolbarProgress(_provider.isLoading),
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
                ProductTable(_provider.filterAlarmStream),
              ],
            ),
          ),
        ));
  }
}
