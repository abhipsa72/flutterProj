import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/line_chart_response.dart';

class LineChartPage extends StatelessWidget {
  final ManagingDirectorProvider _provider;

  LineChartPage(this._provider);

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => _provider.lineChartStream,
      initialData: null,
      child: Consumer<LineChartResponse>(
        builder: (_, lineChart, child) {
          if (lineChart == null) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text("Loading"),
                ),
              ),
            );
          }
          return buildCard(context, lineChart);
        },
      ),
    );
  }

  buildCard(BuildContext context, LineChartResponse response) {
    final lineChart1 = List<Sales>();
    final currentData = response.currentData;
    final yearBackData = response.yearBackData;
    for (int i = 0; i < currentData.length; i++) {
      lineChart1.add(Sales(yearBackData[i].date, currentData[i].sales));
    }
    final lineChart2 = List<Sales>();

    for (int i = 0; i < yearBackData.length; i++) {
      lineChart2.add(Sales(yearBackData[i].date, yearBackData[i].sales));
    }

    final line = [
      charts.Series<Sales, DateTime>(
        id: "current year",
        data: lineChart1,
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Colors.greenAccent[200]),
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sales,
      ),
      charts.Series<Sales, DateTime>(
        id: "last year",
        data: lineChart2,
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sales,
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Sales Trends",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 300,
              child: charts.TimeSeriesChart(
                line,
                defaultRenderer: charts.LineRendererConfig(),
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                behaviors: [
                  charts.SeriesLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: true,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                  ),
                ],
                domainAxis: charts.DateTimeAxisSpec(
                  tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                    month: charts.TimeFormatterSpec(
                      format: 'dd',
                      transitionFormat: 'dd MMM',
                    ),
                  ),
                ),
                /*  primaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                desiredTickCount: 6,
              ),
            ),*/
                /*defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  stacked: true,
                ),
                domainAxis: charts.NumericAxisSpec(
                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 7,
                  ),
                  tickFormatterSpec: customTickFormatter,
                ),*/
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final customTickFormatter = charts.BasicNumericTickFormatterSpec(
  (num value) {
    if (value == 0) {
      return "Mon";
    } else if (value == 1) {
      return "Tue";
    } else if (value == 2) {
      return "Wed";
    } else if (value == 3) {
      return "Thr";
    } else if (value == 4) {
      return "Fri";
    } else if (value == 5) {
      return "Sat";
    } else if (value == 6) {
      return "Sun";
    }
    return "";
  },
);
