import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/finance/action_done/action_done_detail.dart';
import 'package:zel_app/finance/finance_page_provider.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/model/action_done.dart';
import 'package:zel_app/model/selected_dates.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class FinanceActionPage extends StatefulWidget {
  @override
  _FinanaceActionPageState createState() => _FinanaceActionPageState();
}

class _FinanaceActionPageState extends State<FinanceActionPage> {
  SelectedDates _selectedDates = SelectedDates();
  List<DateTime> selectedDates = List();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<FinanceProviderBloc>(context);

    showBottomSheetDialog(BuildContext context) {
      showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (context) {
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Filter",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _provider.getFilterList();
                  },
                  child: Text("Save"),
                  color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
            ],
          );
        },
      );
    }

    showDatePickerDialog(BuildContext context) async {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: DateTime.now(),
        firstDate: DateTime(2015),
        initialLastDate: (DateTime.now()).add(
          Duration(days: 7),
        ),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked.length == 2 && picked != selectedDates) {
        setState(() {
          selectedDates = picked;
          var formatter =  DateFormat('dd/MM/yyyy');
          _selectedDates.fromDate = formatter.format(picked[0]);
          _selectedDates.endDate = formatter.format(picked[1]);
          _provider.setFromAndEndDates(_selectedDates);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Products inprogress"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showBottomSheetDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Hive.openBox(userDetailsBox).then(
                    (value) {
                  value.clear().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false));
                },
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDatePickerDialog(context);
        },
        child: Icon(Icons.date_range),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<ActionDone>>(
              stream: _provider.actionListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<ActionDone> products = snapshot.data;
                  return showProducts(products, _provider, context);
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }

  Column showProducts(
      List<ActionDone> products,
      FinanceProviderBloc _provider,
      BuildContext context,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Products",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (_, index) {
            ActionDone product = products[index];
            return ListTile(
              title: Text(product.description),
              subtitle: Text(product.category),
//              trailing: Text(
//                departmentValues.reverse[product.department],
//              ),
              onTap: () {
                _provider.setActionDone = product;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FinanceDetailsPage(product),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
