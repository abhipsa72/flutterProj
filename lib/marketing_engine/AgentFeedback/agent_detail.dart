// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:zel_app/marketing_engine/market_engine_provider.dart';
// import 'package:zel_app/model/existing_campaign.dart';
//
// class AgentDetails extends StatelessWidget {
//   final ExistingCampaignModel _camps;
//   AgentDetails(this._camps);
//
//   @override
//   Widget build(BuildContext context) {
//     final _provider = Provider.of<MarketingEngineProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Associated targetlist"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Divider(
//               height: 32,
//               endIndent: 16,
//               indent: 16,
//             ),
//             StreamBuilder<ExistingCampaignModel>(
//               stream: _provider.campStream,
//               builder: (_, snapshot) {
//                 ExistingCampaignModel products = snapshot.data;
//                 return showProduct(products.associatedTargetList, products,
//                     _provider, context);
//               },
//             ),
//             SizedBox(
//               height: 72,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// showProduct(
//   List<AssociatedTargetList> rc,
//   ExistingCampaignModel products,
//   MarketingEngineProvider _provider,
//   BuildContext context,
// ) {
//   // _provider.targetListApi();
//
//   return Column(children: <Widget>[
//     Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text(
//         "Customer List",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//     ListView.builder(
//       //controller: _scrollController,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: rc.length,
//       itemBuilder: (_, index) {
//         AssociatedTargetList camp = rc[index];
//
//         return Center(
//             child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 title: RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "   ${camp.custMob}",
//                       )
//                     ],
//                     text: "${camp.custName}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).accentColor,
//                     ),
//                   ),
//                 ),
//                 subtitle: Text(camp.id),
//               ),
//               Divider(),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextButton(
//                     child: const Text('Mark Complete'),
//                     onPressed: () {
//                       showAlert(context);
//                     },
//                   ),
//                   const SizedBox(width: 8),
//                 ],
//               ),
//             ],
//           ),
//         ));
//       },
//     ),
//   ]);
// }
//
// showAlert(BuildContext context) {
//   TextEditingController _c;
//   MarketingEngineProvider _provider;
//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10.0))),
//         content: Column(
//           children: <Widget>[
//             new TextField(
//               decoration: new InputDecoration(hintText: "Enter your feedback"),
//               controller: _c,
//             ),
//             new FlatButton(
//               child: new Text("Save"),
//               onPressed: () {
//                 //_provider.createActionlist(_c.text, targetlistIds);
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         ),
//       );
//     },
//   );
// }
