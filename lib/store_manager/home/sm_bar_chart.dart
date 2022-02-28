import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/charts/bar_chart.dart';
import 'package:zel_app/model/bar_chart_response.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';

class SMBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    return StreamBuilder(
        stream: _chartsProvider.barChartStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            BarChartResponse response = snapshot.data;
            if (response == null) {
              return Container();
            }
            return showBarChart(context, response);
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
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
        });
  }

  showBarChart(BuildContext context, BarChartResponse response) {
    BarChartData yearBackData = response.currentData;
    BarChartData currentData = response.yearBackData;

    final l1 = [
      BarData("FMCG", currentData.fmcg),
      BarData("OF", currentData.oaf),
      BarData("FF", currentData.ff),
      BarData("EA", currentData.eaa),
      BarData("LHH", currentData.llh),
      BarData("FAL", currentData.fal),
    ];
    final t1 = [
      BarData("FMCG", yearBackData.fmcg),
      BarData("OF", yearBackData.oaf),
      BarData("FF", yearBackData.ff),
      BarData("EA", yearBackData.eaa),
      BarData("LHH", yearBackData.llh),
      BarData("FAL", yearBackData.fal),
    ];
    final chart = [
      charts.Series<BarData, String>(
        id: 'Current',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: l1,
      ),
      charts.Series<BarData, String>(
        id: 'Year Back',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.greenAccent),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: t1,
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Division Contribution',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 250,
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
                  // charts.PercentInjector(
                  //   totalType: charts.PercentInjectorTotalType.domain,
                  // )
                ],
                //primaryMeasureAxis: charts.PercentAxisSpec(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
