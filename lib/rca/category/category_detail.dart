import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/category/category_model.dart';
import 'package:zel_app/rca/rca_provider.dart';

class CategoryDetailsPage extends StatefulWidget {
  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  final _numberController = TextEditingController();
  final headerText = TextStyle(fontWeight: FontWeight.bold);
  final padding = EdgeInsets.all(16);
  final boxDecoration = BoxDecoration(color: Colors.grey[100]);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Details"),
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
              CategoryTable(_provider.categoryStream),
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

class CategoryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);
    final formatter = new NumberFormat("#,###");
    return StreamBuilder<Category>(
      stream: _category,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Category category = snapshot.data;
          return Table(
            children: [
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Category Id",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(category.categoryCode.toString()),
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
                    child: Text(formatter.format(category.budget)),
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
                    child: Text(formatter.format(category.sales)),
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
                    child: Text(formatter.format(category.categoryVariation)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Variation %",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child:
                        Text(category.categoryVariationPercentage.toString()),
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
                    child: Text(formatter.format(category.losses)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Loss share %",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(category.lossesPercentage.toString()),
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

  final Stream<Category> _category;

  CategoryTable(this._category);
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
