import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/finance/finance_page_provider.dart';
import 'package:zel_app/finance/finance_progress.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/views/status_card.dart';

class AlarmUpdatesPage extends StatelessWidget {
  final AlarmDetailsResponse response;

  AlarmUpdatesPage(this.response);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<FinanceProviderBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Consumer<FinanceProviderBloc>(
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
                          builder: (context) => FinanceProgressCompleted()),
                    );
                    _provider.financeProductList();
                  },
                  child: StatusCard(
                    Icons.alarm,
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
                          builder: (context) => FinanceProgressWip()),
                    );
                    _provider.financeProductList();
                  },
                  child: StatusCard(
                    Icons.alarm,
                    Colors.lightGreenAccent,
                    "Alarm Work In Progress",
                    response.wip.toString(),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _provider.filterAlaram("UA"),
                  child: StatusCard(
                    Icons.alarm,
                    Colors.yellow,
                    "Alarm Unattended",
                    response.ua.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
