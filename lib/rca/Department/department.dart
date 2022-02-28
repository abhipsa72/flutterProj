import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/Department/department_detail.dart';
import 'package:zel_app/rca/Department/department_model.dart';
import 'package:zel_app/rca/Section/section.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class DepartmentPage extends StatefulWidget {
  final storeId;
  DepartmentPage(this.storeId);
  @override
  _DepartmentPageState createState() => _DepartmentPageState(storeId);
}

class _DepartmentPageState extends State<DepartmentPage> {
  final storeId;
  String _dropDownValue;
  _DepartmentPageState(this.storeId);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Departments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Dept>>(
              stream: _provider.deptListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Dept> dept = snapshot.data;
                  dept.sort((a, b) =>
                      a.lossesPercentage.compareTo(b.lossesPercentage));
                  if (dept.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading departmenrts..."),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            showProducts(dept, _provider, context)
                          ]));
                } else if (snapshot.hasError) {
                  return Center(
                    heightFactor: 30,
                    child: Text(
                      dioError(snapshot.error),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Loading departmenrts..."),
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
    List<Dept> department,
    RCAProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: department.length,
          itemBuilder: (_, index) {
            Dept dept = department[index];
            final formatter = new NumberFormat("#,###");
            return ListTile(
              title: Text(dept.department),
              subtitle: Text(
                "Loss Percentage :  " + dept.lossesPercentage.toString() + "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: dept.lossesPercentage >= 25
                      ? Colors.redAccent
                      : dept.lossesPercentage >= 20 &&
                              dept.lossesPercentage < 25
                          ? Colors.yellow[900]
                          : dept.lossesPercentage >= 10 &&
                                  dept.lossesPercentage < 20
                              ? Colors.yellow[700]
                              : dept.lossesPercentage >= 5 &&
                                      dept.lossesPercentage < 10
                                  ? Colors.green[300]
                                  : Colors.green[700],
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.blueAccent,
                  onPressed: () => {
                        _provider.setDept = dept,
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DepartmentDetailsPage(),
                          ),
                        )
                      }),
              onTap: () {
                _provider.getSection(storeId, dept.departmentCode.toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SectionPage(storeId),
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
