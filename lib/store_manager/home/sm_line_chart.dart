import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/line_chart_response.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';

class SMLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    return StreamBuilder(
      stream: _chartsProvider.lineChartStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          LineChartResponse response = snapshot.data;
          if (response == null) {
            return Container();
          }
          return showLineChart(context, response);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Container();
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
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
    );
  }

  showLineChart(BuildContext context, LineChartResponse response) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    response.currentData.sort((a, b) => a.date.compareTo(b.date));
    response.yearBackData.sort((a, b) => a.date.compareTo(b.date));

    final currentData = response.currentData;
    final yearBackData = response.yearBackData;

    final lineChart1 = List<Sales>();
    final lineChart2 = List<Sales>();
    var length = min(currentData.length, yearBackData.length);
    for (int i = 0; i < length; i++) {
      print("Current ${currentData[i].date}");
      lineChart1.add(Sales(currentData[i].date, currentData[i].sales));
      lineChart2.add(Sales(currentData[i].date, yearBackData[i].sales));
    }

    List<charts.Series<Sales, DateTime>> _seriesLineData =
        List<charts.Series<Sales, DateTime>>();

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Colors.greenAccent[200]),
        id: 'Current year',
        data: lineChart1..toList(),
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sales,
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
        id: ' last Year',
        data: lineChart2.toList(),
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sales,
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sales ',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 250,
              child: charts.TimeSeriesChart(
                _seriesLineData,
                //  animate: true,
                defaultRenderer: charts.LineRendererConfig(),
                behaviors: [
                  charts.SeriesLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: true,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                  ),
                ],
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                domainAxis: charts.DateTimeAxisSpec(
                  //tickProviderSpec: charts.DayTickProviderSpec(increments: [7]),
                  tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                    month: charts.TimeFormatterSpec(
                      format: 'dd',
                      transitionFormat: 'dd MMM',
                    ),
                  ),
                  //showAxisLine: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
