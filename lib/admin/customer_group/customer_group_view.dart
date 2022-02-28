import 'package:flutter/material.dart';
import 'package:grand_uae/admin/customer_group/customer_group_model.dart';
import 'package:grand_uae/admin/model/customer_group_response.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class CustomerGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer groups'),
      ),
      body: Consumer<CustomerGroupModel>(
        builder: (context, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return Center(
              child: Text("Error"),
            );
          }
          return ListView.builder(
            itemCount: model.customerGroupList.length,
            itemBuilder: (context, index) {
              CustomerGroup customerGroup = model.customerGroupList[index];
              return ListTile(
                title: Text(customerGroup.name),
                trailing: IconButton(
                  onPressed: () {
                    //model.deleteCustomer(customerGroup);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
