import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/home/home_model.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/customer/views/network_category_image.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeModel>(
      builder: (_, value, child) {
        if (value.categories == null) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (value.categories.isEmpty) {
          return Container();
        }
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Categories".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    value.navigateToSubList(
                      routes.CategoryListRoute,
                      value.categories,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: Text("View all"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                )
              ],
            ),
            Container(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.categories.length,
                itemBuilder: (_, index) {
                  var category = value.categories[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        value.goToProductList(category);
                      },
                      child: Container(
                        width: size.width / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: NetworkCategoryImage(
                                category.metaTitle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                category.name.toHtmlUnescapeCapitalize(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
