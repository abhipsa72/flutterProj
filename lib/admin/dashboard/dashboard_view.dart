import 'package:flutter/material.dart';
import 'package:grand_uae/admin/dashboard/dashboard_model.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                ExpansionTile(
                  leading: Icon(Icons.dashboard),
                  title: Text("Catalog"),
                  children: [
                    ListTile(
                      title: Text("Categories"),
                      onTap: model.navigateCategory,
                    ),
                    ListTile(
                      title: Text("Products"),
                      onTap: model.navigateProducts,
                    ),
                    ListTile(
                      title: Text("Manufactures"),
                      onTap: model.navigateManufacturer,
                    ),
                    ExpansionTile(
                      title: Text("Attributes"),
                      children: [
                        ListTile(
                          title: Text("All"),
                          onTap: model.navigateAttributes,
                        ),
                        ListTile(
                          title: Text("Groups"),
                          onTap: model.navigateCategory,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.group),
                  title: Text("Customer"),
                  children: <Widget>[
                    ListTile(
                      title: Text("All"),
                      onTap: model.navigateCustomer,
                    ),
                    ListTile(
                      title: Text("Groups"),
                      onTap: model.navigateCustomerGroup,
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.point_of_sale_sharp),
                  title: Text("Sales"),
                  children: <Widget>[
                    ListTile(
                      title: Text("Orders"),
                      onTap: model.navigateOrders,
                    ),
                    /*ListTile(
                      title: Text("Returns"),
                      onTap: model.navigateCustomer,
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
