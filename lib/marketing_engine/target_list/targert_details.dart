import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/model/target_model.dart';

class TargetDetailsPage extends StatelessWidget {
  final TargetModel _product;

  TargetDetailsPage(this._product);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TargetTable(_provider.productStream),
          ],
        ),
      ),
    );
  }
}

class TargetTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headerText = TextStyle(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.all(16);
    final boxDecoration = BoxDecoration(color: Colors.grey[100]);

    return StreamBuilder<TargetModel>(
      stream: _product,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          TargetModel detail = snapshot.data;
          return Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "id",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.id),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "customer code",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.custCode),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "customer category",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.custCategory),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "customer mobile",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.custMob),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "location",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.location),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "lastPurchDate",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.lastPurchDate.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "stores",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.status),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "idleDays",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.idleDays.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "frequency90",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.frequency90.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "frequency180",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.frequency180.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "frequency360",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.frequency360.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "recency",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.recency.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "timegapRatio",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.timegapRatio.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "sales_90",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.sales_90.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "sales_180",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.sales_180.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "sales_360",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.sales_360.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "transactions90",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.transactions90.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "transactions180",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.transactions180.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "transactions360",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.transactions360.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "basket90",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.basket90.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "basket180",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.basket180.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "basket360",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.basket360.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "priority90",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.priority90.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "priority180",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.priority180.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "priority360",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.priority360.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "marginPerc",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.marginPerc.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "favWeek",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.favWeek.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "favDay",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.favDay.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "favTime",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.favTime.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the30Subgroup1",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the30Subgroup1.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the30Subgroup2",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the30Subgroup2.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the30Subgroup3",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the30Subgroup3.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the90Subgroup1",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the90Subgroup1.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the180Subgroup1",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the180Subgroup1.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "the360Subgroup1",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.the360Subgroup1.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "message",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.message.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "channel",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.channel.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "testControlFlag",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.testControlFlag.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "campaign",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.campaign.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "timePeriod",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.timePeriod.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "preBasket",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.preBasket.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "preSales",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.preSales.toString()),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: padding,
                    child: Text(
                      "preTrxn",
                      style: headerText,
                    ),
                  ),
                  Padding(
                    padding: padding,
                    child: Text(detail.preTrxn.toString()),
                  ),
                ],
              ),
            ],
          );
        } else
          return Container();
      },
    );
  }

  final Stream<TargetModel> _product;

  TargetTable(this._product);
}
