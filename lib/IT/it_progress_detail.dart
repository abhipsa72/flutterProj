import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/IT/it_provider.dart';
import 'package:zel_app/warehouse_manager/product/warehouse_manager_product_detail.dart';

class ItProgressDetail extends StatefulWidget {
  @override
  _ProductStatusState createState() =>
      _ProductStatusState();
}
class _ProductStatusState extends State<ItProgressDetail> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ItProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Details page"),
          bottom: PreferredSize(
            child: ToolbarProgress(_provider.isLoadingStream),
            preferredSize: Size(double.infinity, 2.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ProductTable(_provider.productStream),
              ],
            ),
          ),
        )
    );
  }
}
class ToolbarProgress extends StatelessWidget {
  final Stream<bool> _isLoading;

  ToolbarProgress(this._isLoading);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isLoading,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          );
        } else
          return Container();
      },
    );
  }
}
