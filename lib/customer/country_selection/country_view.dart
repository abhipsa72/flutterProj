import 'package:flutter/material.dart';
import 'package:grand_uae/customer/country_selection/country.dart';
import 'package:grand_uae/customer/country_selection/country_model.dart';
import 'package:grand_uae/main.dart';
import 'package:provider/provider.dart';

class CountrySelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountrySelectionModel>(
      create: (_) => CountrySelectionModel(),
      child: Consumer<CountrySelectionModel>(
        builder: (_, locationService, child) {
          if (locationService.countries.isEmpty) {
            return Material(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        locationService.loadingText,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    locationService.restartButton
                        ? RaisedButton(
                            onPressed: () {
                              RestartWidget.restartApp(context);
                            },
                            child: Text("Restart"),
                          )
                        : Container()
                  ],
                ),
              ),
            );
          }
          if (locationService.countries.isNotEmpty) {
            return CountryGridView(
              locationService.countries,
              locationService.countryName,
            );
          }
          return Material(
            child: Center(
              child: Text(
                "Something went wrong please try again.",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
