import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zel_app/rca/SubCategory/SubCategory.dart';
import 'package:zel_app/rca/category/category_detail.dart';
import 'package:zel_app/rca/category/category_model.dart';
import 'package:zel_app/rca/rca_provider.dart';
import 'package:zel_app/util/ExceptionHandle.dart';

class CategoryPage extends StatefulWidget {
  final storeId;
  CategoryPage(this.storeId);
  @override
  _CategoryPageState createState() => _CategoryPageState(storeId);
}

class _CategoryPageState extends State<CategoryPage> {
  final storeId;
  _CategoryPageState(this.storeId);
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<RCAProvider>(context);
    String _dropDownValue;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<List<Category>>(
              stream: _provider.categoryListStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<Category> category = snapshot.data;
                  category.sort((a, b) =>
                      a.lossesPercentage.compareTo(b.lossesPercentage));
                  if (category.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Loading categories..."),
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
                            showProducts(category, _provider, context)
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
                            child: Text("Loading categories..."),
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
    List<Category> categories,
    RCAProvider _provider,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (_, index) {
            Category category = categories[index];
            final formatter = new NumberFormat("#,###");
            return ListTile(
              title: Text(category.category),
              subtitle: Text(
                "Loss Percentage :  " +
                    category.lossesPercentage.toString() +
                    "%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: category.lossesPercentage >= 25
                      ? Colors.redAccent
                      : category.lossesPercentage >= 20 &&
                              category.lossesPercentage < 25
                          ? Colors.yellow[900]
                          : category.lossesPercentage >= 10 &&
                                  category.lossesPercentage < 20
                              ? Colors.yellow[700]
                              : category.lossesPercentage >= 5 &&
                                      category.lossesPercentage < 10
                                  ? Colors.green[300]
                                  : Colors.green[700],
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  color: Colors.blueAccent,
                  onPressed: () => {
                        _provider.setCategory = category,
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailsPage(),
                          ),
                        )
                      }),
              onTap: () {
                _provider.getSubCategory(
                    storeId, category.categoryCode.toString());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SubCategoryPage(storeId),
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
