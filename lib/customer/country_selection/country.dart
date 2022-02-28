import 'package:flutter/material.dart';
import 'package:grand_uae/customer/country_selection/country_model.dart';
import 'package:grand_uae/customer/model/login_country.dart';
import 'package:provider/provider.dart';

class CountryGridView extends StatelessWidget {
  final Map<String, LoginCountry> countries;
  final String countryName;

  CountryGridView(
    this.countries,
    this.countryName,
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<CountrySelectionModel>(
      builder: (_, model, child) {
        return Material(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                            "Welcome to Grand hyper",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(4),
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width >= 700
                                    ? 4
                                    : 2,
                          ),
                          itemCount: countries.values.toList().length,
                          itemBuilder: (_, index) {
                            final country = countries.values.toList()[index];
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  model.setAndGo(country);
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      country.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Current location: $countryName"),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
