import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/product_compare/product_compare_model.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:provider/provider.dart';

class ProductCompareView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compare products"),
      ),
      body: Consumer<ProductCompareModel>(
        builder: (_, model, child) {
          if (model.state == ViewState.Busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.state == ViewState.Error) {
            return RetryButton(
              errorMessage: model.errorMessage,
              onPressed: () {
                model.fetchProductComparison();
              },
            );
          }
          if (model.products.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.shoppingBasket,
                    size: 72,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "No products to compare",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(""),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Price"),
                ),
                DataColumn(
                  label: Text("Model"),
                ),
                DataColumn(
                  label: Text("Brand"),
                ),
                DataColumn(
                  label: Text("Availability"),
                ),
                DataColumn(
                  label: Text("Rating"),
                ),
                DataColumn(
                  label: Text("Summary"),
                ),
                DataColumn(
                  label: Text("Weight"),
                ),
                DataColumn(
                  label: Text("Dimensions (L x W x H)"),
                ),
              ],
              rows: model.products
                  .map((product) => DataRow(cells: [
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              model.deleteProduct(product.productId);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        DataCell(
                          GestureDetector(
                            child: Text(
                              product.name,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              model.navigateToProduct(product);
                            },
                          ),
                        ),
                        DataCell(
                          Text("${product.price}"),
                        ),
                        DataCell(
                          Text(product.model),
                        ),
                        DataCell(
                          Text(
                            "${product.manufacturer?.firstLetterToUpperCase()}",
                          ),
                        ),
                        DataCell(
                          Text(
                              "${stockStatusValues.reverse[product.stockStatus]}"),
                        ),
                        DataCell(
                          Text(product.rating.toString()),
                        ),
                        DataCell(
                          Text(product.description),
                        ),
                        DataCell(
                          Text(product.weight),
                        ),
                        DataCell(
                          Text(
                              "${product.length} x ${product.weight} x ${product.height}"),
                        ),
                      ]))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
