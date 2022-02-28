import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/model/data_response.dart';
import 'package:zel_app/store_manager/home/sm_bar_chart.dart';
import 'package:zel_app/store_manager/home/sm_line_chart.dart';
import 'package:zel_app/store_manager/home/sm_pie_chart.dart';
import 'package:zel_app/store_manager/home/sm_stack_bar_chart.dart';
import 'package:zel_app/store_manager/home_page_provider.dart';
import 'package:zel_app/store_manager/product/product_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _chartsProvider = Provider.of<ChartsProvider>(context);
    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<AlarmDetailsResponse>(
              stream: _chartsProvider.alarmDetailsStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  AlarmDetailsResponse response = snapshot.data;
                  if (response == null) {
                    return Container();
                  }
                  return AlarmDetailsPage(response);
                } else if (snapshot.hasError) {
                  print("a");
                  logout(context);
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
            ),
            // StreamProvider(
            //   create: (_) => _chartsProvider.alarmDetailsStream,
            //   initialData: null,
            //   child: Consumer<AlarmDetailsResponse>(
            //     builder: (_, response, child) {
            //       if (response == null) {
            //         return Container();
            //       }
            //       return AlarmDetailsPage(response);
            //     },
            //   ),
            // ),
            Divider(
              height: 50,
              endIndent: 16,
              indent: 16,
            ),
            SMLineChart(),
            Divider(
              height: 50,
              endIndent: 16,
              indent: 16,
            ),
            SMPieChart(),
            Divider(
              height: 50,
              endIndent: 16,
              indent: 16,
            ),
            SMBarChart(),
            Divider(
              height: 50,
              endIndent: 16,
              indent: 16,
            ),
            SMBubbleChart(),
            SizedBox(
              height: 96,
            )
          ],
        ),
      ),
    );
  }
}
