import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/charts/bar_chart.dart';
import 'package:zel_app/managing_director/charts/flow_progress_chart.dart';
import 'package:zel_app/managing_director/charts/line_chart.dart';
import 'package:zel_app/managing_director/charts/sales_impact_chart.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/role_details.dart';
import 'package:zel_app/model/saled_impact_chart.dart';

class ManagingDirectorChart extends StatefulWidget {
  @override
  _ManagingDirectorChartState createState() => _ManagingDirectorChartState();
}

class _ManagingDirectorChartState extends State<ManagingDirectorChart> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ManagingDirectorProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Consumer<ManagingDirectorProvider>(
              builder: (_, dates, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "From ${dates.selectedDates?.fromDate} - To ${dates.selectedDates?.endDate}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            LineChartPage(_provider),
            BarChartPage(_provider),
            StreamProvider(
              create: (context) => _provider.saleImpactStream,
              initialData: null,
              child: Consumer<SalesImpact>(
                builder: (_, salesChart, child) {
                  if (salesChart == null) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text("Loading"),
                        ),
                      ),
                    );
                  }
                  return SalesImpactChart(salesChart);
                },
              ),
            ),
            StreamProvider(
              create: (context) => _provider.roleDetailsStream,
              initialData: null,
              child: Consumer<RoleDetails>(
                builder: (_, roleDetails, child) {
                  if (roleDetails == null) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text("Loading"),
                        ),
                      ),
                    );
                  }
                  return FlowChart(roleDetails);
                },
              ),
            ),
            SizedBox(
              height: 72,
            )
          ],
        ),
      ),
    );
  }
}
