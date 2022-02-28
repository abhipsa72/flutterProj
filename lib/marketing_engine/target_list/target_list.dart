import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zel_app/constants.dart';
import 'package:zel_app/intro/login/login_page.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/marketing_engine/target_list/targert_details.dart';
import 'package:zel_app/model/target_model.dart';

class TargetList extends StatefulWidget {
  @override
  _TargetListState createState() => _TargetListState();
}

class _TargetListState extends State<TargetList> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _c;

  var _saved = List();
  var userStatus = List<bool>();
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    return ValueListenableBuilder(
        valueListenable: Hive.box(userDetailsBox).listenable(),
        builder: (_, Box box, __) {
          Hive.openBox(userDetailsBox);
          String token = box.get(authTokenBoxKey);
          _provider.setAuthToken(token);
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                AppBar(
                  title: Text("Marketing engine"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        showBottomSheetDialog(context, _provider);
                      },
                    ),
                    IconButton(
                      tooltip: "Logout",
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        logout(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                  height: 10,
                ),

                // crossAxisAlignment: CrossAxisAlignment.stretch,
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showTextField(context);
                    }),
                StreamBuilder<List<TargetModel>>(
                  stream: _provider.productListStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      List<TargetModel> products = snapshot.data;
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
              ])));
        });
  }

  showProduct(
    List<TargetModel> rc,
    MarketingEngineProvider _provider,
    BuildContext context,
  ) {
    // _provider.targetListApi();

    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Customers",
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
          TargetModel product = rc[index];
          userStatus.add(false);
          var tmpArray = [];
          // getCheckboxItems() {
          //   product.forEach((key, value) {
          //     if (value == true) {
          //       tmpArray.add(value);
          //     }
          //   });
          //   print(tmpArray);
          //   // Here you will get all your selected Checkbox items.
          //
          //   // Clear array after use.
          //   tmpArray.clear();
          // }

          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: " •   ${product.custMob}",
                            recognizer: new TapGestureRecognizer()
                              ..onTap =
                                  () => launch(('tel://${product.custMob}'))),
                      ],
                      text: "${product.custName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  // trailing: Text(product.custMob),
                  subtitle: Text(product.message),
                  leading: Checkbox(
                      value: userStatus[index],
                      onChanged: (bool val) {
                        _provider.chechedBox();
                        userStatus[index] = !userStatus[index];
                        if (val == true) {
                          _saved.add(index);
                          print(_saved);
                        } else {
                          _saved.remove(index);
                        }
                      }),
                  onTap: () {
                    _provider.setProduct = product;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TargetDetailsPage(product),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }
}

void logout(BuildContext context) {
  Hive.openBox(userDetailsBox).then((value) {
    value.clear().then((value) => Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (route) => false));
  });
}

showTextField(BuildContext context) {
  MarketingEngineProvider _provider;
  TextEditingController _c;
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(hintText: "Enter Campaign name"),
              controller: _c,
            ),
            new FlatButton(
              child: new Text("Save"),
              onPressed: () {
                //_provider.createActionlist(_c.text, targetlistIds);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}

showBottomSheetDialog(
  BuildContext context,
  MarketingEngineProvider _provider,
) {
  _provider.getTimePeriod();
  _provider.getLocation();
  _provider.getChannel();
  _provider.getCampaign();

  double _currentSliderValue = 20;
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Filter",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.timePeriodStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Time period",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select TimePeriod"),
                        value: _provider.selectedTime,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedTime = val;
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.channelStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Channel",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Channel"),
                        value: _provider.selectedChannel,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedChannel = val;
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          Divider(
            height: 10,
            indent: 16,
            endIndent: 16,
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.campaignStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Campaign",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Campaign"),
                        value: _provider.selectedCampaign,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedCampaign = val;
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          StatefulBuilder(
            builder: (_, StateSetter setState) {
              return StreamBuilder<List<String>>(
                stream: _provider.locationStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Location",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        hint: Text("Select Location"),
                        value: _provider.selectedLocation,
                        onChanged: (val) {
                          setState(() {
                            _provider.setSelectedLocation = val;
                          });
                        },
                        items: snapshot.data.map((role) {
                          return DropdownMenuItem(
                            child: Text(role.toString()),
                            value: role,
                          );
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: MaterialButton(
              onPressed: () {
                _provider.filterTargetList();

                Navigator.of(context).pop();
              },
              child: Text("Save"),
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.all(16.0),
            ),
          ),
        ],
      );
    },
  );
}
