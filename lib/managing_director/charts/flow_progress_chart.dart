import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zel_app/model/role_details.dart';

class FlowChart extends StatelessWidget {
  final RoleDetails roleDetails;

  FlowChart(this.roleDetails);

  @override
  Widget build(BuildContext context) {
    final comp = [
      RoleChart(
        "Analytics",
        roleDetails.roleAnalytics.comp,
      ),
      RoleChart(
        "Finance",
        roleDetails.roleFinance.comp,
      ),
      RoleChart(
        "Manager",
        roleDetails.roleInwardManager.comp,
      ),
      RoleChart(
        "IT",
        roleDetails.roleIt.comp,
      ),
      RoleChart(
        "Purchase",
        roleDetails.rolePurchaser.comp,
      ),
      RoleChart(
        "Store",
        roleDetails.roleStoreManager.comp,
      ),
    ];
    final ua = [
      RoleChart(
        "Analytics",
        roleDetails.roleAnalytics.ua,
      ),
      RoleChart(
        "Finance",
        roleDetails.roleFinance.ua,
      ),
      RoleChart(
        "Manager",
        roleDetails.roleInwardManager.ua,
      ),
      RoleChart(
        "IT",
        roleDetails.roleIt.ua,
      ),
      RoleChart(
        "Purchase",
        roleDetails.rolePurchaser.ua,
      ),
      RoleChart(
        "Store",
        roleDetails.roleStoreManager.ua,
      ),
    ];
    final wip = [
      RoleChart(
        "Analytics",
        roleDetails.roleAnalytics.wip,
      ),
      RoleChart(
        "Finance",
        roleDetails.roleFinance.wip,
      ),
      RoleChart(
        "Manager",
        roleDetails.roleInwardManager.wip,
      ),
      RoleChart(
        "IT",
        roleDetails.roleIt.wip,
      ),
      RoleChart(
        "Purchase",
        roleDetails.rolePurchaser.wip,
      ),
      RoleChart(
        "Store",
        roleDetails.roleStoreManager.wip,
      ),
    ];
    final chart = [
      charts.Series<RoleChart, String>(
        id: 'COMP',
        colorFn: (_, __) =>  charts.ColorUtil.fromDartColor(Colors.blueAccent),
        domainFn: (RoleChart sales, _) => sales.name,
        measureFn: (RoleChart sales, _) => sales.value,
        data: comp,
      ),
      charts.Series<RoleChart, String>(
        id: 'UA',
        colorFn: (_, __) =>  charts.ColorUtil.fromDartColor(Colors.green),
        domainFn: (RoleChart sales, _) => sales.name,
        measureFn: (RoleChart sales, _) => sales.value,
        data: ua,
      ),
      charts.Series<RoleChart, String>(
        id: 'WIP',
        colorFn: (_, __) =>  charts.ColorUtil.fromDartColor(Colors.orange),
        domainFn: (RoleChart sales, _) => sales.name,
        measureFn: (RoleChart sales, _) => sales.value,
        data: wip,
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pending issue",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 200,
              child: charts.BarChart(
                chart,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [
                  charts.SeriesLegend(
                    outsideJustification:
                    charts.OutsideJustification.endDrawArea,
                    horizontalFirst: true,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                  ),
                  charts.PercentInjector(
                    totalType: charts.PercentInjectorTotalType.domain,
                  )
                ],
                primaryMeasureAxis: charts.PercentAxisSpec(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
