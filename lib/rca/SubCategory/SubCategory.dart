import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/SubCategory/subCategory_details.dart';
import 'package:zel_app/rca/SubCategory/subCategory_model.dart';
import 'package:zel_app/rca/products/remark.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class SubCategoryPage extends StatefulWidget {
  final storeId;
  SubCategoryPage(this.storeId);
  @override
  _SubCategoryState createState() => _SubCategoryState(storeId);
}

class _SubCategoryState extends State<SubCategoryPage> {
  static List<String> departments = [
    "Coconut oil",
    "Cooking oil",
    "Vegetable ghee",
    "Mustard oil",
    "Cumin oil",
    "Vegetable oil",
    "Sunflower oil",
    "Almond oil",
    "olive oil"
  ];
  final storeId;
  _SubCategoryState(this.storeId);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    String _dropDownValue;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Category"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Subcategory>>(
              stream: _provider.subcategoryListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Subcategory> subCategory = snapshot.data;
                  subCategory.sort((a, b) =>
                      a.lossesPercentage.compareTo(b.lossesPercentage));
                  if (subCategory.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading subcategories..."),
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
                            showProducts(subCategory, _provider, context)
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
                            child: Text("Loading subcategories..."),
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
    List<Subcategory> subCategories,
    RCAProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: subCategories.length,
          itemBuilder: (_, index) {
            Subcategory subCategory = subCategories[index];
            final formatter = new NumberFormat("#,###");
            return ListTile(
              title: Text(subCategory.subcategory),
              subtitle: Text(
                "Variation percentage :  " +
                    subCategory.lossesPercentage.toString() +
                    "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: subCategory.lossesPercentage >= 25
                      ? Colors.redAccent
                      : subCategory.lossesPercentage >= 20 &&
                              subCategory.lossesPercentage < 25
                          ? Colors.yellow[900]
                          : subCategory.lossesPercentage >= 10 &&
                                  subCategory.lossesPercentage < 20
                              ? Colors.yellow[700]
                              : subCategory.lossesPercentage >= 5 &&
                                      subCategory.lossesPercentage < 10
                                  ? Colors.green[300]
                                  : Colors.green[700],
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.blueAccent,
                  onPressed: () => {
                        _provider.setSubCategory = subCategory,
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SubCategoryDetailsPage(),
                          ),
                        )
                      }),
              onTap: () {
                _provider.getRemark(storeId, subCategory.subcategoryCode);
                _provider.productGraph(storeId, subCategory.subcategoryCode);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductRca(storeId),
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
