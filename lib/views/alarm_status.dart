import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/views/status_card.dart';
import 'package:zel_app/warehouse_manager/product/product_progress.dart';
import 'package:zel_app/warehouse_manager/warehouse_manager_provider.dart';

class AlarmStatusPage extends StatelessWidget {
  final AlarmDetailsResponse response;

  AlarmStatusPage(this.response);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<WarehouseManagerProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Consumer<WarehouseManagerProvider>(
          builder: (_, dates, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "From ${dates.selectedDates?.fromDate} - To ${dates.selectedDates?.endDate}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
        Container(
          height: 166,
          width: 170,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    _provider.filterAlaram("COMPLETED");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductProgressComplete(),
                      ),
                    );
                    _provider.wareHouseProductList();
                  },
                  child: StatusCard(
                    Icons.battery_full,
                    Colors.pinkAccent[100],
                    "Alarm completed",
                    response.comp.toString(),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    _provider.filterAlaram("WIP");
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductProgressWIP(),
                      ),
                    );
                    _provider.wareHouseProductList();
                  },
                  child: StatusCard(
                    Icons.battery_charging_full,
                    Colors.lightGreenAccent,
                    "Alarm Work In Progress",
                    response.wip.toString(),
                  ),
                ),
              ),
              Expanded(
                child: StatusCard(
                  Icons.battery_alert,
                  Colors.yellow,
                  "Alarm Unattended",
                  response.ua.toString(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
