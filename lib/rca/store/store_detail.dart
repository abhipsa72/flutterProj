import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/rca/store/store_model.dart';

class StoreDetailsPage extends StatefulWidget {
  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Store detail"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProductTable(_provider.storeStream),
              SizedBox(
                height: 16,
              ),
            ],
          ),
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
    final formatter = new NumberFormat("#,###");
    return StreamBuilder<Store>(
      stream: _region,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Store store = snapshot.data;
          return Table(
            children: [
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Id",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(store.storeId.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Budget",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(formatter.format(store.budget)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Sales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(formatter.format(store.sales)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Variation",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(formatter.format(store.variation)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Variation percentage",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(store.variationPercentage.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Loss",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(store.losses.toString()),
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

  final Stream<Store> _region;

  ProductTable(this._region);
}

class ToolbarProgress extends StatelessWidget {
  final Stream<bool> _isLoading;

  ToolbarProgress(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLoading,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          );
        } else
          return Container();
      },
    );
  }
}
