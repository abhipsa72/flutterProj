import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zel_app/model/saled_impact_chart.dart';

class SalesImpactChart extends StatelessWidget {
  final SalesImpact salesChart;

  SalesImpactChart(this.salesChart);

  @override
  Widget build(BuildContext context) {
    final data = [
      Sale(
        "Less Visibility",
        salesChart.lessVisibility,
      ),
      Sale(
        "Price increased",
        salesChart.priceIncreased,
      ),
      Sale(
        "Stocked out yesterday",
        salesChart.lessVisibility,
      ),
    ];
    final chart = [
      charts.Series<Sale, String>(
        id: "Sales Impact",
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Sale sales, _) => sales.name,
        measureFn: (Sale sales, _) => sales.value,
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Impact of sales alarms",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 300,
              child: charts.BarChart(
                chart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
