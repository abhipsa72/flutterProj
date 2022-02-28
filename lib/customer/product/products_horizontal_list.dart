import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/product/product_item.dart';

class HorizontalProducts extends StatelessWidget {
  final List<Product> _products;
  final String _title;

  HorizontalProducts(this._title, this._products);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Builder(
        builder: (_) {
          if (_products == null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (_products.isEmpty) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _title,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    var product = _products[index];
                    return ProductItem(product);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
