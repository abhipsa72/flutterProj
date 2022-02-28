import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/Section/section_detail.dart';
import 'package:zel_app/rca/Section/section_model.dart';
import 'package:zel_app/rca/category/category.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class SectionPage extends StatefulWidget {
  final storeId;
  SectionPage(this.storeId);
  @override
  _SectionPageState createState() => _SectionPageState(storeId);
}

class _SectionPageState extends State<SectionPage> {
  final storeId;
  _SectionPageState(this.storeId);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    String _dropDownValue;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sections"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Section>>(
              stream: _provider.secListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Section> section = snapshot.data;
                  section.sort((a, b) =>
                      a.lossesPercentage.compareTo(b.lossesPercentage));
                  if (section.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading sections..."),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            showProducts(section, _provider, context)
                          ]));
                } else if (snapshot.hasError) {
                  return Center(
                    heightFactor: 30,
                    child: Text(
                      dioError(snapshot.error),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Loading sections..."),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Column showProducts(
    List<Section> sections,
    RCAProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sections.length,
          itemBuilder: (_, index) {
            Section section = sections[index];
            final formatter = new NumberFormat("#,###");
            return ListTile(
              title: Text(section.section),
              subtitle: Text(
                "Variation percentage :  " +
                    section.lossesPercentage.toString() +
                    "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: section.lossesPercentage >= 25
                      ? Colors.redAccent
                      : section.lossesPercentage >= 20 &&
                              section.lossesPercentage < 25
                          ? Colors.yellow[900]
                          : section.lossesPercentage >= 10 &&
                                  section.lossesPercentage < 20
                              ? Colors.yellow[700]
                              : section.lossesPercentage >= 5 &&
                                      section.lossesPercentage < 10
                                  ? Colors.green[300]
                                  : Colors.green[700],
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.blueAccent,
                  onPressed: () => {
                        _provider.setSection = section,
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SecationDetailsPage(),
                          ),
                        )
                      }),
              onTap: () {
                _provider.getCategory(storeId, section.sectionCode.toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryPage(storeId),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
