import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/marketing_engine/AgentFeedback/AgentDetail.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/model/existing_campaign.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class AgenFeedback extends StatefulWidget {
  @override
  _AgenFeedbackState createState() => _AgenFeedbackState();
}

class _AgenFeedbackState extends State<AgenFeedback> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    return ValueListenableBuilder(
        valueListenable: Hive.box(userDetailsBox).listenable(),
        builder: (_, Box box, __) {
          Hive.openBox(userDetailsBox);
          String token = box.get(authTokenBoxKey);
          _provider.setTokenAgent(token);
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Ttem 1"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
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
                  StreamBuilder<List<ExistingCampaignModel>>(
                    stream: _provider.existCampStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<ExistingCampaignModel> products = snapshot.data;
                        if (products.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("No data")),
                          );
                        }
                        return showProduct(products, _provider, context);
                      } else if (snapshot.hasError) {
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
  List<ExistingCampaignModel> rc,
  MarketingEngineProvider _provider,
  BuildContext context,
) {
  // _provider.targetListApi();

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
        ExistingCampaignModel camp = rc[index];
        final TextEditingController _editCamp = TextEditingController();
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(camp.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange)),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "  (${camp.createdDate})",
                        ),
                      ],
                      text: "${camp.timePeriod}",
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  onTap: () {
                    _provider.setCampaign = camp;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AgentDetailsPage(camp.associatedTargetList),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
      },
    ),
  ]);
}
