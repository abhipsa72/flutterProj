import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/Department/department_model.dart';
import 'package:zel_app/rca/rca_provider.dart';

class DepartmentDetailsPage extends StatefulWidget {
  @override
  _DepartmentDetailsPageState createState() => _DepartmentDetailsPageState();
}

class _DepartmentDetailsPageState extends State<DepartmentDetailsPage> {
  final _numberController = TextEditingController();
  final headerText = TextStyle(fontWeight: FontWeight.bold);
  final padding = EdgeInsets.all(16);
  final boxDecoration = BoxDecoration(color: Colors.grey[100]);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Department detail"),
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
              DepartmentDetail(_provider.deptStream),
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

class DepartmentDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);
    final formatter = new NumberFormat("#,###");
    return StreamBuilder<Dept>(
      stream: _depts,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Dept dept = snapshot.data;
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
                    child: Text(dept.departmentCode.toString()),
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
                    child: Text(formatter.format(dept.budget)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
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
                    child: Text(formatter.format(dept.departmentVariation)),
                  ),
                ],
              ),
              TableRow(
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
                    child: Text(dept.departmentVariationPercentage.toString()),
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
                    child: Text(formatter.format(dept.losses)),
                  ),
                ],
              ),
              TableRow(
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
                    child: Text(formatter.format(dept.sales)),
                  ),
                ],
              ),
              TableRow(
                decoration: boxDecoration,
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "Loss Percentage",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(dept.lossesPercentage.toString()),
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

  final Stream<Dept> _depts;

  DepartmentDetail(this._depts);
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
