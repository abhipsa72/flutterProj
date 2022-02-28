import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/model/recommendationSummary.dart';
import 'package:zel_app/views/status_card.dart';

class RecommendationSummary extends StatefulWidget {
  @override
  _RecommendationSummaryState createState() => _RecommendationSummaryState();
}

class _RecommendationSummaryState extends State<RecommendationSummary> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    List<RecommendationSummaryModel> rc;
    return ValueListenableBuilder(
        valueListenable: Hive.box(userDetailsBox).listenable(),
        builder: (_, Box box, __) {
          Hive.openBox(userDetailsBox);
          String token = box.get(authTokenBoxKey);
          _provider.setTokenForSummary(token);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppBar(
                    title: Text("Marketing engine"),
                    actions: <Widget>[
                      IconButton(
                        tooltip: "Logout",
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          logout(context);
                        },
                      ),
                    ],
                  ),
                  StreamBuilder<List<RecommendationSummaryModel>>(
                    stream: _provider.summaryStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<RecommendationSummaryModel> products =
                            snapshot.data;
                        if (products.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("No data")),
                          );
                        }
                        return showProduct(products, _provider, context);
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(snapshot.error.toString()),
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
                  ),
                  SizedBox(
                    height: 72,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

showProduct(
  List<RecommendationSummaryModel> rc,
  MarketingEngineProvider _provider,
  BuildContext context,
) {
  return Column(children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Campaigns",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ListView.builder(
      //controller: _scrollController,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: rc.length,
      itemBuilder: (_, index) {
        RecommendationSummaryModel rSum = rc[index];

        return Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                // onTap: ()=> _provider.filterAlaram("COMPLETED") ,
                onTap: () async {},
                child: StatusCard(
                  Icons.battery_full,
                  Colors.pinkAccent[100],
                  "Inactive",
                  rSum.campigns.inactive.call,
                ),
              ),
            ),
          ],
        );
      },
    ),
  ]);
}
