import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Your Account"),
          ),
          body: GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              createCard(
                "Details",
                Icons.person,
                Colors.orange,
                () => model.navigateToUserDetail(),
              ),
              createCard(
                "Your Addresses",
                Icons.pin_drop,
                Colors.green,
                () => model.navigateTo(routes.ShowAddressListRoute),
              ),
              createCard(
                "Your Orders",
                Icons.markunread_mailbox_sharp,
                Colors.blue,
                () => model.navigateTo(routes.OrderHistoryRoute),
              ),
              createCard(
                "Change password",
                Icons.lock,
                Colors.red,
                () => model.navigateTo(routes.ChangePasswordRoute),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget createCard(
    String title,
    IconData icon,
    Color color,
    Function onPressed,
  ) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 72,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
