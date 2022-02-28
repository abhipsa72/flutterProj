import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_provider.dart';
import 'package:zel_app/model/bar_chart_md.dart';

class BarChartPage extends StatelessWidget {
  final ManagingDirectorProvider _provider;

  BarChartPage(this._provider);
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => _provider.barChartStream,
      initialData: null,
      child: Consumer<DepartmentSales>(
        builder: (_, response, child) {
          if (response == null) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text("Loading"),
                ),
              ),
            );
          }
          return showBarChartMd(context, response);
        },
      ),
    );
  }
}

//   final DepartmentSales _response;
//
//   BarChartPage(this._response);
//
//   @override
//   Widget build(BuildContext context) {
showBarChartMd(BuildContext context, DepartmentSales response) {
  Data yearBackData = response.yearBackData;
  Data currentData = response.currentData;
  final l1 = [
    BarData("FMCH", yearBackData.fmcg),
    BarData("OF", yearBackData.oaf),
    BarData("FF", yearBackData.ff),
    BarData("EA", yearBackData.eaa),
    BarData("LHH", yearBackData.llh),
    BarData("FAL", yearBackData.fal),
//      BarData("CS", _response[0].cs),
//      BarData("SS", _response[0].ss),
//      BarData("GIFT", _response[0].gift),
//      BarData("AE", _response[0].ae),
//      BarData("AD", _response[0].ad),
//      BarData("RTAS", _response[0].rtas),
  ];
  final t1 = [
    BarData("FMCH", currentData.fmcg),
    BarData("OF", currentData.oaf),
    BarData("FF", currentData.ff),
    BarData("EA", currentData.eaa),
    BarData("LHH", currentData.llh),
    BarData("FAL", currentData.fal),
//      BarData("CS", _response[1].cs),
//      BarData("SS", _response[1].ss),
//      BarData("GIFT", _response[1].gift),
//      BarData("AE", _response[1].ae),
//      BarData("AD", _response[1].ad),
//      BarData("RTAS", _response[1].rtas),
  ];
  final chart = [
    charts.Series<BarData, String>(
      id: 'Last Year',
      colorFn: (_, __) =>
          charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
      domainFn: (BarData sales, _) => sales.name,
      measureFn: (BarData sales, _) => sales.value,
      data: l1,
    ),
    charts.Series<BarData, String>(
      id: 'Current Year',
      colorFn: (_, __) =>
          charts.ColorUtil.fromDartColor(Colors.greenAccent[200]),
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
          Text(
            "Sales share",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 250,
            child: charts.BarChart(
              chart,
              barGroupingType: charts.BarGroupingType.grouped,
              behaviors: [
                charts.SeriesLegend(
                  outsideJustification: charts.OutsideJustification.endDrawArea,
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

class BarData {
  String name;
  num value;

  BarData(this.name, this.value);
}
