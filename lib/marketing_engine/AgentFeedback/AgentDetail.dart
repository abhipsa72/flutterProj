import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/marketing_engine/AgentFeedback/agent_feedback.dart';
import 'package:zel_app/marketing_engine/market_engine_provider.dart';
import 'package:zel_app/model/existing_campaign.dart';

class AgentDetailsPage extends StatefulWidget {
  final List<AssociatedTargetList> camp;
  AgentDetailsPage(this.camp);
  @override
  _AgentDetailsPageState createState() => _AgentDetailsPageState(camp);
}

class _AgentDetailsPageState extends State<AgentDetailsPage> {
  TextEditingController _c;
  List<AssociatedTargetList> camp;
  _AgentDetailsPageState(this.camp);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<MarketingEngineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder<ExistingCampaignModel>(
                stream: _provider.campStream,
                builder: (_, snapshot) {
                  ExistingCampaignModel products = snapshot.data;
                  return showProduct(camp, products, _provider, _c, context);
                },
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showFormDialog(MarketingEngineProvider _provider, BuildContext context,
    TextEditingController _c) {
  var alert = new AlertDialog(
    title: Text("Set Reminder"),
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
                        labelText: "Campaign",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hint: Text(" status"),
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
          height: 16,
        ),
        TextFormField(
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
            prefixIcon: Icon(Icons.calendar_today),
          ),
        ),
        // Date
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        padding: const EdgeInsets.all(16.0),
        onPressed: () {
          //_provider.saveDetails();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AgenFeedback(),
            ),
          );
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

showProduct(
  List<AssociatedTargetList> rc,
  ExistingCampaignModel products,
  MarketingEngineProvider _provider,
  TextEditingController _c,
  BuildContext context,
) {
  // _provider.targetListApi();

  return Column(children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Customer List",
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
        AssociatedTargetList campi = rc[index];

        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "   ${campi.custMob}",
                      )
                    ],
                    text: "${campi.custName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                subtitle: Text(campi.id),
                onTap: () {
                  _provider.setCampaignList = campi;
                  _showFormDialog(_provider, context, _c);
                },
              ),
            ],
          ),
        ));
      },
    ),
  ]);
}
