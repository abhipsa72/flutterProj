import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zel_app/marketing_engine/existing_campaign/camp_detail.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/model/existing_campaign.dart';

class AssociatedList extends StatefulWidget {
  @override
  _AssociatedListState createState() => _AssociatedListState();
}

class _AssociatedListState extends State<AssociatedList> {
  _AssociatedListState();
  TextEditingController _c;
  bool status = false;
  //var selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Associated targetlist"),
      ),
      body: StreamBuilder<ExistingCampaignModel>(
          stream: _provider.campStream,
          builder: (_, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              ExistingCampaignModel products = snapshot.data;
              return showProduct(products.associatedTargetList, products.id,
                  _provider, context, _c);
            } else
              return Container();
          }),
    );
  }

  showProduct(
    List<AssociatedTargetList> rc,
    String actionId,
    MarketingEngineProvider _provider,
    BuildContext context,
    TextEditingController _c,
  ) {
    // _provider.targetListApi();

    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: rc.length,
      itemBuilder: (_, index) {
        AssociatedTargetList cust = rc[index];
        // disableButton(channelValues.reverse[cust.channel]);
        this.status = cust.called;
        ValueNotifier<bool> _remarkNotifier = ValueNotifier(status);
        void _showFormDialog(
            List<AssociatedTargetList> rc,
            MarketingEngineProvider _provider,
            BuildContext context,
            TextEditingController _c,
            String id,
            String actionId) {
          var alert = new AlertDialog(
            title: Text("Feedback"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StatefulBuilder(
                  builder: (_, StateSetter setState) {
                    return StreamBuilder<List<String>>(
                      stream: _provider.customerStatusStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Status",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              hint: Text("Customer Status"),
                              value: _provider.selectedStatus,
                              onChanged: (val) {
                                setState(() {
                                  _provider.setSelectedStatus = val;
                                });
                              },
                              items: snapshot.data.map((status) {
                                return DropdownMenuItem(
                                  child: Text(status.toString()),
                                  value: status,
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
                  height: 12,
                ),

                Container(
                  margin: const EdgeInsets.only(right: 14, left: 14),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _c,
                    maxLines: 1,
                    onChanged: _provider.agentFeedback,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: "Enter feedback",
                      labelText: "Feedback",
                      prefixIcon: Icon(Icons.edit_outlined),
                    ),
                  ),
                )

                // Date
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                padding: const EdgeInsets.all(16.0),
                onPressed: () {
                  status = _remarkNotifier.value;
                  _provider.saveDetails(id, actionId);
                  Navigator.pop(context);
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );

          showDialog(
              context: context,
              builder: (_) {
                return alert;
              });
        }

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      children: [
                        Text(
                          cust.custName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () {
                            launch(('tel://${cust.custMob}'));
                          },
                          child: new Text(
                            cust.custMob,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      cust.channel == Channel.CALL
                          ? IconButton(
                              icon: Icon(Icons.call_outlined),
                              color: Colors.blueAccent,
                              onPressed: () => {
                                    launch(('tel://${cust.custMob}'))
                                    // _provider.existingCampaign();
                                  })
                          : Container(),
                      cust.channel == Channel.SMS
                          ? IconButton(
                              icon: Icon(Icons.message),
                              color: Colors.green,
                              onPressed: () {
                                void _sendSMS(String message,
                                    List<String> recipents) async {
                                  String _result = await sendSMS(
                                          message: message,
                                          recipients: recipents)
                                      .catchError((onError) {
                                    print(onError);
                                  });
                                  print(_result);
                                }

                                _sendSMS(cust.message, [cust.custMob]);
                                // _provider.existingCampaign();
                              },
                            )
                          : Container(),
                      cust.channel == Channel.CALL_SMS
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.call_outlined),
                                      color: Colors.blueAccent,
                                      onPressed: () => {
                                            launch(('tel://${cust.custMob}'))
                                            // _provider.existingCampaign();
                                          }),
                                  IconButton(
                                    icon: Icon(Icons.message),
                                    color: Colors.green,
                                    onPressed: () {
                                      void _sendSMS(String message,
                                          List<String> recipents) async {
                                        String _result = await sendSMS(
                                                message: message,
                                                recipients: recipents)
                                            .catchError((onError) {
                                          print(onError);
                                        });
                                        print(_result);
                                      }

                                      _sendSMS(cust.message, [cust.custMob]);
                                      // _provider.existingCampaign();
                                    },
                                  )
                                ])
                          : Container(),
                    ]),
                    subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(cust.message)
                        ]),
                    onTap: () {
                      _provider.setCampaignList = cust;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CampaignDetailsPage(cust),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ValueListenableBuilder(
                      valueListenable: _remarkNotifier,
                      builder: (BuildContext context, status, Widget child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                'Mark Complete',
                                style: TextStyle(
                                    color: status == false
                                        ? Colors.blue
                                        : Colors.grey),
                              ),
                              onPressed: () {
                                status == false
                                    ? _showFormDialog(rc, _provider, context,
                                        _c, cust.id, actionId)
                                    : null;
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        );
                      }),
                ],
              ),
            ));
      },
    );
  }
}
