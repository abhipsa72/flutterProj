import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/managing_director/managing_director_page.dart';
import 'package:zel_app/rca/Region/region_detail.dart';
import 'package:zel_app/rca/Region/region_model.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/rca/store/store.dart';
import 'package:zel_app/util/ExceptionHandle.dart';
import 'package:zel_app/views/aboutDetail.dart';
import 'package:zel_app/views/profile.dart';

class RCA extends StatefulWidget {
  static var routeName = "/rca";
  @override
  _RCAState createState() => _RCAState();
}

class _RCAState extends State<RCA> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    final formatter = new NumberFormat("#,###");
    return ValueListenableBuilder(
        valueListenable: Hive.box(userDetailsBox).listenable(),
        builder: (_, Box box, __) {
          Hive.openBox(userDetailsBox);
          String token = box.get(authTokenBoxKey);
          String name = box.get(userNameBoxKey);
          String email = box.get(userEmailBoxKey);
          String store = box.get(userStoreKey);
          _provider.setAuthTokenAndCompanyId(token);
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
                        MaterialPageRoute(builder: (context) => ProfilePage()),
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
                        _exitApp(context);
                      },
                      leading: Icon(Icons.exit_to_app)),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text("Regions"),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<List<Region>>(
                    stream: _provider.regionListStream,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        List<Region> regions = snapshot.data;

                        return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Time period:  " + regions[0].timePeriod,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: regions.length,
                                    itemBuilder: (_, index) {
                                      Region region = regions[index];
                                      return ListTile(
                                        title: Text(region.region),
                                        subtitle: Text(
                                          "Variation percentage :  " +
                                              region.variationPercentage
                                                  .toString() +
                                              "%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: region.variationPercentage <=
                                                    -10
                                                ? Colors.redAccent
                                                : region.variationPercentage >=
                                                            -10 &&
                                                        region.variationPercentage <=
                                                            0
                                                    ? Colors.yellow[900]
                                                    : region.variationPercentage <=
                                                                10 &&
                                                            0 <=
                                                                region
                                                                    .variationPercentage
                                                        ? Colors.yellow[700]
                                                        : Colors.green,
                                          ),
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(
                                                Icons.keyboard_arrow_right),
                                            color: Colors.blueAccent,
                                            onPressed: () => {
                                                  _provider.setRegion = region,
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegionDetailsPage(),
                                                    ),
                                                  )
                                                }),
                                        onTap: () {
                                          _provider.getStore(region.regionId);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => StorePage(),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ]));
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(dioError(snapshot.error)),
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
                                  child: Text("Loading regions..."),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('We hate to see you leave...'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  logout(context);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Column showProducts(
    List<Region> regions,
    RCAProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[],
    );
  }
}
