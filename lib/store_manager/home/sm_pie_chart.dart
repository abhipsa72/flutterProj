import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/pie_chart_response.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class SMPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    return StreamBuilder(
      stream: _chartsProvider.pieChartStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          PieChartResponse response = snapshot.data;

          if (response == null) {
            return Container();
          }
          return showPieChart(context, response);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());

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

  showPieChart(BuildContext context, PieChartResponse response) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
//    var pieChart = [
//      Task('Stackout-cmp', response.others[0], Colors.deepOrange[200]),
//      Task('Stackut-wip', response.others[1], Colors.deepOrange[300]),
//      Task('Stackout-ua', response.others[2], Colors.deepOrange[400]),
//      Task('Visibility-cmp', response.visibility[0], Colors.green[200]),
//      Task('Visibility-wip', response.visibility[1], Colors.green[300]),
//      Task('Visibility-ua', response.visibility[2], Colors.green[400]),
//      Task('Others-cmp', response.stock[0], Colors.blue[200]),
//      Task('Others-ua', response.stock[1], Colors.blue[300]),
//      Task('Others-wip', response.stock[2], Colors.blue[400]),
//    ];

    var pieChart2 = [
      Task(
          'Less visibility',
          response.lessVisibilityCompetitorOffersHrIssuesWeatherImpact,
          Colors.blue),
      Task('Stocked out', response.stockedOutYesterday, Colors.green),
      Task('price increased', response.priceIncreasedFromPreviousWeeks,
          Colors.deepOrangeAccent),
    ];
    final _pieChart2 = [
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        id: 'Alarm completed',
        data: pieChart2,
        labelAccessorFn: (Task row, _) => '${row.taskValue}',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Reasons Vs Alaram',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 350,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: charts.PieChart(
                _pieChart2,
                behaviors: [
                  charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 2,
                    cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                  )
                ],
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 100,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.auto,
                      )
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
