import 'package:flutter/material.dart';
import 'package:grand_uae/constants/constants.dart';
import 'package:grand_uae/customer/enums/connectivity_status.dart';
import 'package:grand_uae/customer/splash/splash_model.dart';
import 'package:grand_uae/customer/views/error_network.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityStatus>(
      builder: (context, value, child) {
        if (value == ConnectivityStatus.Offline) {
          return NoInternet();
        }
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(color: Theme.of(context).primaryColor),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).cardColor,
                            radius: 50.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset("images/grand_logo.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              appName,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Consumer<SplashModel>(
                      builder: (context, model, child) {
                        if (model.state == ViewState.Error) {
                          return RetryButton(
                            errorMessage: model.message,
                            onPressed: () => model.fetchDetails(),
                            colored: false,
                          );
                        }
                        if (model.state == ViewState.Busy) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).textTheme.headline6.color,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Loading",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                ),
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
