import 'package:flutter/material.dart';
import 'package:zel_app/marketing_engine/AgentFeedback/agent_feedback.dart';
import 'package:zel_app/marketing_engine/existing_campaign/existing_campaign.dart';
import 'package:zel_app/marketing_engine/target_list/target_list.dart';

class MarketEngine extends StatefulWidget {
  static var routeName = "/marketer";
  @override
  _MarketEngineState createState() => _MarketEngineState();
}

class _MarketEngineState extends State<MarketEngine> {
  int _currentIndex = 0;
  List<Widget> _children = [AgenFeedback(), TargetList(), ExistingCampaign()];

  onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabSelected,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Summmary"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Target List"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Campaigns"),
            ),
          ],
          currentIndex: _currentIndex,
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
