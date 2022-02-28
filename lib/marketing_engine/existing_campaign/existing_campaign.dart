import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/marketing_engine/existing_campaign/campaign_details.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/marketing_engine/target_list/target_list.dart';
import 'package:zel_app/model/existing_campaign.dart';
import 'package:zel_app/util/enum_values.dart';
import 'package:zel_app/views/NoInternet.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';

class ExistingCampaign extends StatefulWidget {
  static var routeName = "/marketer";
  @override
  _ExistingCampaignState createState() => _ExistingCampaignState();
}

class _ExistingCampaignState extends State<ExistingCampaign> {
  final TextEditingController _ediController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    return Consumer<ConnectivityStatus>(builder: (_, value, child) {
      if (value == ConnectivityStatus.Offline) {
        return NoInternet();
      }
      return ValueListenableBuilder(
          valueListenable: Hive.box(userDetailsBox).listenable(),
          builder: (_, Box box, __) {
            Hive.openBox(userDetailsBox);
            String token = box.get(authTokenBoxKey);
            String name = box.get(userNameBoxKey);
            String email = box.get(userEmailBoxKey);
            String store = box.get(userStoreKey);
            _provider.setToken(token);
            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration:
                          BoxDecoration(color: Theme.of(context).canvasColor),
                      accountName: Text(
                        name.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      accountEmail: Text(
                        store.toString(),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Theme.of(context).canvasColor,
                        child: Image.asset(
                          "assets/zedeye_logo.png",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text("Profile"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text("About"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        );
                      },
                    ),
                    ListTile(
                        title: Text("Logout"),
                        onTap: () {
                          logout(context);
                        },
                        leading: Icon(Icons.exit_to_app)),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AppBar(
                      title: Text("Action list"),
                      // actions: <Widget>[
                      //   IconButton(
                      //     tooltip: "Logout",
                      //     icon: Icon(Icons.exit_to_app),
                      //     onPressed: () {
                      //       logout(context);
                      //     },
                      //   ),
                      // ],
                    ),
                    StreamBuilder<List<ExistingCampaignModel>>(
                      stream: _provider.existCampStream,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          List<ExistingCampaignModel> products = snapshot.data;
                          if (products.isEmpty) {
                            return Image(
                                image: AssetImage('assets/no_data_found.png'));
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
    });
  }

  showProduct(List<ExistingCampaignModel> rc, MarketingEngineProvider _provider,
      BuildContext context) {
    // _provider.targetListApi();

    return Column(children: <Widget>[
      ListView.builder(
        //controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: rc.length,
        itemBuilder: (_, index) {
          ExistingCampaignModel camp = rc[index];

          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: Colors.deepOrange,
              elevation: 3,
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
                            text: "    (${camp.createdDate})",
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
                          builder: (context) => AssociatedList(),
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
}

showEdit(BuildContext context, TextEditingController _ediController, String id,
    MarketingEngineProvider _provider) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _ediController,
              maxLines: 1,
              //onChanged: _provider.editAction(_c.text),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "campaign name",
                //labelText: "Target days",
                prefixIcon: Icon(Icons.edit_outlined),
              ),
            ),
            new FlatButton(
              child: new Text("Save"),
              onPressed: () {
                _provider.editCampaign(id, _ediController.text);
                Navigator.pop(context);

                //_provider.existingCampaign();
              },
            )
          ],
        ),
      );
    },
  );
}
