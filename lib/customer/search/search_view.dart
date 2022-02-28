import 'package:flutter/material.dart';
import 'package:grand_uae/customer/enums/sort_with_order.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/customer/search/search_list_products.dart';
import 'package:grand_uae/customer/search/search_model.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).appBarTheme.iconTheme.color;
    return Consumer<SearchModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_sharp),
            ),
            titleSpacing: 0,
            bottom: PreferredSize(
              child: model.state == ViewState.Busy
                  ? SizedBox(
                      height: 2.0,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).textTheme.headline6.color,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : Container(),
              preferredSize: Size(double.infinity, 0.5),
            ),
            title: TextFormField(
              autofocus: true,
              onChanged: (query) {
                if (query.isNotEmpty && query.length > 3) {
                  model.search(query);
                } else {
                  model.productsList = [];
                }
              },
              style: TextStyle(
                color: color,
                fontSize: 18,
              ),
              textInputAction: TextInputAction.search,
              controller: model.searchQuery,
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: TextStyle(color: color.withOpacity(0.5)),
                hintText: 'Search products',
                suffixIcon: model.searchQuery.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: color,
                        ),
                        onPressed: () {
                          model.searchQuery.clear();
                        },
                      )
                    : Icon(
                        Icons.search,
                        color: color,
                      ),
              ),
            ),
          ),
          body: SearchViewProducts(),
          endDrawer: Drawer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 8,
                ),
                child: Consumer<SearchModel>(
                  builder: (BuildContext context, model, Widget child) {
                    return Column(
                      children: [
                        DropdownButtonFormField<SortWithOrder>(
                          isDense: true,
                          hint: Text("Select sort"),
                          decoration: InputDecoration(
                            labelText: "Sort",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          value: model.selectedSort,
                          items: SortWithOrder.values
                              .map((sort) => DropdownMenuItem(
                                    child: Text(getNameOfSort(sort)),
                                    value: sort,
                                  ))
                              .toList(),
                          onChanged: (sort) {
                            model.selectedSort = sort;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Builder(
                          builder: (_) {
                            if (model.categories.isEmpty) {
                              return Container();
                            }
                            return DropdownButtonFormField<Category>(
                              isDense: true,
                              selectedItemBuilder: (BuildContext context) {
                                return model.subCategories
                                    .map<Widget>((category) {
                                  return Text(
                                    category.name.toHtmlUnescapeCapitalize(),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }).toList();
                              },
                              isExpanded: true,
                              hint: Text("Select Category"),
                              decoration: InputDecoration(
                                labelText: "Category",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              value: model.selectedCategory,
                              items: model.categories
                                  .map((category) => DropdownMenuItem(
                                        child: Text(
                                          category.name
                                              .toHtmlUnescapeCapitalize(),
                                        ),
                                        value: category,
                                      ))
                                  .toList(),
                              onChanged: (category) {
                                model.selectedCategory = category;
                                model.fetchSubCategories(category.categoryId);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Builder(
                          builder: (_) {
                            if (model.subCategories.isEmpty) {
                              return Container();
                            }
                            return DropdownButtonFormField<Category>(
                              isDense: true,
                              isExpanded: true,
                              hint: Text("Select Sub Category"),
                              decoration: InputDecoration(
                                labelText: "Category",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              value: model.selectedSubCategory,
                              items: model.subCategories
                                  .map((category) => DropdownMenuItem(
                                        child: Text(
                                          category.name
                                              .toHtmlUnescapeCapitalize(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        value: category,
                                      ))
                                  .toList(),
                              selectedItemBuilder: (BuildContext context) {
                                return model.subCategories
                                    .map<Widget>((category) {
                                  return Text(
                                    category.name.toHtmlUnescapeCapitalize(),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }).toList();
                              },
                              onChanged: (category) {
                                model.selectedSubCategory = category;
                              },
                            );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlineButton(
                                onPressed: () {
                                  model.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Text("Clear"),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  model.search(model.searchQuery.text);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Apply"),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
