import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zel_app/rca/products/rca_bar_model.dart';

class RcaBarChart extends StatelessWidget {
  final List<Result> response;

  RcaBarChart(this.response);

  @override
  Widget build(BuildContext context) {
    final l1 = List<BarData>();
    for (int i = 0; i < response.length; i++) {
      l1.add(BarData(response[i].bin, response[i].binLevelPercentage));
    }
//     final l1 = [
//       BarData(_response[0].bin, _response[0].binLevelPercentage),
//       BarData(_response[1].bin, _response[1].binLevelPercentage),
//       //BarData(_response[2].bin, _response[2].binLevelPercentage),
//       // BarData("EA", _response[0].eaa),
//       // BarData("LHH", _response[0].llh),
//       // BarData("FAL", _response[0].fal),
// //      BarData("CS", _response[0].cs),
// //      BarData("SS", _response[0].ss),
// //      BarData("GIFT", _response[0].gift),
// //      BarData("AE", _response[0].ae),
// //      BarData("AD", _response[0].ad),
// //      BarData("RTAS", _response[0].rtas),
//     ];
    final t1 = List<BarData>();
    for (int i = 0; i < response.length; i++) {
      t1.add(BarData(response[i].bin, response[i].countPercentage));
    }
//     final t1 = [
//       BarData(_response[0].bin, _response[0].countPercentage),
//       BarData(_response[1].bin, _response[1].countPercentage),
//       // BarData(_response[2].bin, _response[2].countPercentage),
//       // BarData("EA", _response[1].eaa),
//       // BarData("LHH", _response[1].llh),
//       // BarData("FAL", _response[1].fal),
// //      BarData("CS", _response[1].cs),
// //      BarData("SS", _response[1].ss),
// //      BarData("GIFT", _response[1].gift),
// //      BarData("AE", _response[1].ae),
// //      BarData("AD", _response[1].ad),
// //      BarData("RTAS", _response[1].rtas),
//     ];
    final chart = [
      charts.Series<BarData, String>(
        id: 'Bin Level Percentage',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.deepPurpleAccent),
        domainFn: (BarData sales, _) => sales.name,
        measureFn: (BarData sales, _) => sales.value,
        data: l1,
      ),
      charts.Series<BarData, String>(
        id: 'Count Percentage',
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
            // Text(
            //   "Sales share",
            //   style: TextStyle(
            //     fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
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

class BarData {
  String name;
  num value;

  BarData(this.name, this.value);
}
