import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/SubCategory/subCategory_model.dart';
import 'package:zel_app/rca/rca_provider.dart';

class SubCategoryDetailsPage extends StatefulWidget {
  @override
  _SubCategoryDetailsPageState createState() => _SubCategoryDetailsPageState();
}

class _SubCategoryDetailsPageState extends State<SubCategoryDetailsPage> {
  final _numberController = TextEditingController();
  final headerText = TextStyle(fontWeight: FontWeight.bold);
  final padding = EdgeInsets.all(16);
  final boxDecoration = BoxDecoration(color: Colors.grey[100]);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Category Details"),
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
              SubCategoryTable(_provider.subcategoryStream),
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

class SubCategoryTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);
    final formatter = new NumberFormat("#,###");
    return StreamBuilder<Subcategory>(
      stream: _subCategory,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Subcategory subcategory = snapshot.data;
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
                    child: Text(subcategory.subcategoryCode.toString()),
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
                    child: Text(formatter.format(subcategory.budget)),
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
                    child: Text(formatter.format(subcategory.sales)),
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
                    child: Text(
                        formatter.format(subcategory.subcategoryVariation)),
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
                    child: Text(
                        subcategory.subcategoryVariationPercentage.toString()),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
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
                    child: Text(formatter.format(subcategory.losses)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Loss percentage",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(subcategory.lossesPercentage.toString()),
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

  final Stream<Subcategory> _subCategory;

  SubCategoryTable(this._subCategory);
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
