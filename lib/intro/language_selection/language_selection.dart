import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/common/intro_header_widget.dart';
import 'package:zel_app/intro/language_selection/language_selection_provider.dart';
import 'package:zel_app/intro/login/login_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  static String routeName = "/";

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? _buildTabletLayout()
              : _buildMobileLayout();
        },
      ),
    );
  }

  _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.account_circle,
          title: "Select language to continue",
          subTitle: " ",
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          child: _commonWidgets(),
        )
      ],
    );
  }

  _buildMobileLayout() {
    return Column(
      children: <Widget>[
        IntroHeaderWidget(
          icon: Icons.account_circle,
          title: "Select language to continue",
          subTitle: " ",
        ),
        SizedBox(
          height: 16,
        ),
        _commonWidgets()
      ],
    );
  }

  _commonWidgets() {
    final _languageProvider = Provider.of<LanguageSelectionProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<LanguageSelectionProvider>(
            builder: (_, provider, __) {
              return DropdownButtonFormField(
                value: _languageProvider.selectedLanguage,
                isDense: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                ),
                hint: Text(
                  "Select language",
                ),
                items: provider.languages.map((String lang) {
                  return DropdownMenuItem<String>(
                    value: lang,
                    child: Text(
                      lang,
                    ),
                  );
                }).toList(),
                onChanged: (String val) {
                  setState(() {});
                  _languageProvider.setSelectedLanguage(val);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MaterialButton(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
            child: Consumer(
              builder: (_, LanguageSelectionProvider provider, __) {
                return _languageProvider.isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    : Text("Start");
              },
            ),
          ),
        )
      ],
    );
  }
}
