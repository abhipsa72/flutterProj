import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/charts/bar_chart.dart';
import 'package:zel_app/model/bobble_chart_response.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';
import 'package:zel_app/store_manager/product/product_list_page.dart';

class SMBubbleChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    return StreamBuilder(
        stream: _chartsProvider.bubbleChartStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            BubbleChartResponse response = snapshot.data;
            if (response == null) {
              return Container();
            }
            return showBubbleChart(context, response);
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            exitApp(context, snapshot.error);
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

  showBubbleChart(BuildContext context, BubbleChartResponse response) {
    final dataCount = [
      BarData("FMCG", response.fmcgCountData[0]),
      BarData("OAF", response.oafCountData[0]),
      BarData("FF", response.ffCountData[0]),
      BarData("EAA", response.eaaCountData[0]),
      BarData("LHH", response.lhhCountData[0]),
      BarData("FAL", response.falCountData[0]),
    ];
    final dataLoss = [
      BarData("FMCG", response.fmcgLosses[0]),
      BarData("OAF", response.oafLosses[0]),
      BarData("FF", response.ffLosses[0]),
      BarData("EAA", response.eaaLosses[0]),
      BarData("LHH", response.lhhLosses[0]),
      BarData("FAL", response.falLosses[0]),
    ];

    final data1Count = [
      BarData("FMCG", response.fmcgCountData[1]),
      BarData("OAF", response.oafCountData[1]),
      BarData("FF", response.ffCountData[1]),
      BarData("EAA", response.eaaCountData[1]),
      BarData("LHH", response.lhhCountData[1]),
      BarData("FAL", response.falCountData[1]),
    ];
    final data1Loss = [
      BarData("FMCG", response.fmcgLosses[1]),
      BarData("OAF", response.oafLosses[1]),
      BarData("FF", response.ffLosses[1]),
      BarData("EAA", response.eaaLosses[1]),
      BarData("LHH", response.lhhLosses[1]),
      BarData("FAL", response.falLosses[1]),
    ];

    final data2Count = [
      BarData("FMCG", response.fmcgCountData[2]),
      BarData("OAF", response.oafCountData[2]),
      BarData("FF", response.ffCountData[2]),
      BarData("EAA", response.eaaCountData[2]),
      BarData("LHH", response.lhhCountData[2]),
      BarData("FAL", response.falCountData[2])
    ];
    final data2Loss = [
      BarData("FMCG", response.fmcgLosses[2]),
      BarData("OAF", response.oafLosses[2]),
      BarData("FF", response.ffLosses[2]),
      BarData("EAA", response.eaaLosses[2]),
      BarData("LHH", response.lhhLosses[2]),
      BarData("FAL", response.falLosses[2]),
    ];

    final chart = [
      charts.Series<BarData, String>(
        id: ' priceChange',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green[700]),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: data1Loss,
      ),
      charts.Series<BarData, String>(
        id: ' Stack out',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.blue),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: data2Count,
      ),
      charts.Series<BarData, String>(
        id: ' others',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.cyan[700]),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: data2Loss,
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
                "Loss Vs Division",
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
                barGroupingType: charts.BarGroupingType.stacked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
