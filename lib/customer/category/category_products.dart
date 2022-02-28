import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/customer/category/category_model.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/product/product_item.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/customer/views/cart_menu_item_tracker.dart';
import 'package:grand_uae/customer/views/color_circular_indicator.dart';
import 'package:grand_uae/customer/views/search_icon.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:provider/provider.dart';

class CategoryWithProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var name = context
            .watch<CategoryModel>()
            ?.category
            ?.name
            ?.toHtmlUnescapeCapitalize() ??
        "";
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(
            left: 0.0,
            right: 0.0,
          ),
          title: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Consumer<CategoryModel>(
            builder: (_, model, child) {
              return StreamBuilder<int>(
                stream: model.maxCount,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '${snapshot.data} Products',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    );
                  }
                  return Container();
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          SearchIcon(),
          CartMenuItemTracker(),
          SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          child: Consumer<CategoryModel>(
            builder: (_, model, child) {
              return model.state == ViewState.Busy
                  ? SizedBox(
                      height: 2.0,
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).textTheme.headline6.color,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : Container();
            },
          ),
          preferredSize: Size(double.infinity, 1.0),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Consumer<CategoryModel>(
              builder: (_, model, child) {
                if (model.subCategories.isNotEmpty)
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: model.subCategories
                        .map((category) => Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                              ),
                              child: InputChip(
                                showCheckmark: false,
                                selectedColor: Theme.of(context).accentColor,
                                checkmarkColor: Colors.black,
                                selected: model.selectedChip == category,
                                label: Text(
                                  category.name.toHtmlUnescapeCapitalize(),
                                ),
                                onSelected: (selected) {
                                  model.selectedChip = category;
                                  model.pageLoadController.reset();
                                  model.setSelectedChip = category;
                                },
                              ),
                            ))
                        .toList(),
                  );
                else
                  return Container();
              },
            ),
          ),
          Expanded(
            child: Consumer<CategoryModel>(
              builder: (context, model, child) {
                return PagewiseGridView.count(
                  pageLoadController: model.pageLoadController,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  itemBuilder: this._itemBuilder,
                  noItemsFoundBuilder: (_) => Text("No items found"),
                  loadingBuilder: (context) {
                    return CircularProgressIndicator();
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<CartProductModel>(
        builder: (_, cartModel, child) {
          if (cartModel.value.isNotEmpty) {
            return FloatingActionButton.extended(
              onPressed: () {
                cartModel.clearCart();
              },
              label: Text(
                cartModel.isLoading ? "Adding items to cart" : "Place order",
                style: TextStyle(fontSize: 18),
              ),
              icon: cartModel.isLoading
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: ColorProgress(Colors.black),
                    )
                  : CartMenuItemTracker(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, product, int index) {
    return ProductItem(product);
  }
}
