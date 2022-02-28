import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/search/search_model.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:provider/provider.dart';

class SearchViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (BuildContext context, SearchModel model, Widget child) {
        if (model.productsList == null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 72,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Search products"),
                ),
              ],
            ),
          );
        }
        if (model.productsList.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 72,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("No search results found"),
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.productsList.length,
            itemBuilder: (_, index) {
              Product product = model.productsList[index];
              print(product.image);
              return InkWell(
                onTap: () {
                  model.navigateToProductDetails(product);
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        width: 80,
                        height: 80,
                        child: NetworkProductImage(
                          imageUrl: product.image,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${product.name}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  product.price,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
