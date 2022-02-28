import 'package:flutter/material.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/customer/views/network_category_image.dart';
import 'package:grand_uae/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryListView extends StatelessWidget {
  final List<Category> _categoryList;
  final NavigationService _navigationService = locator<NavigationService>();

  CategoryListView(this._categoryList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (_, index) {
          var category = _categoryList[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                _navigationService.navigateTo(
                  routes.SubCategoryRoute,
                  arguments: category,
                );
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    child: NetworkCategoryImage(
                      category.metaTitle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          category.name.toHtmlUnescapeCapitalize(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
