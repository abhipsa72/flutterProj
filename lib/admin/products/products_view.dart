import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:grand_uae/admin/enums/sort_with_product.dart';
import 'package:grand_uae/admin/products/products_model.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [filterProducts()],
      ),
      body: Consumer<ProductsModel>(
        builder: (_, model, child) {
          return PagewiseListView(
            pageLoadController: model.pageLoadController,
            loadingBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Loading",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            noItemsFoundBuilder: (_) => Text("No products found"),
            itemBuilder: (context, product, index) {
              return Card(
                child: Row(
                  children: [
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: NetworkProductImage(
                        imageUrl: product.image,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            product.price,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget filterProducts() {
    return Builder(
      builder: (context) => IconButton(
        icon: Icon(Icons.sort),
        onPressed: () {
          showBottomSheet(
            elevation: 16,
            backgroundColor: Colors.grey[100],
            context: context,
            builder: (_) {
              return Consumer<ProductsModel>(
                builder: (_, model, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: model.nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter name',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: model.modelController,
                        decoration: InputDecoration(
                          labelText: 'Model',
                          hintText: 'Enter model',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: model.priceController,
                              decoration: InputDecoration(
                                labelText: 'Price',
                                hintText: 'Enter price',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: model.quantityController,
                              decoration: InputDecoration(
                                labelText: 'Quantity',
                                hintText: 'Enter quantity',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<SortWithProduct>(
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
                        value: model.sortWithProduct,
                        items: SortWithProduct.values
                            .map((sort) => DropdownMenuItem(
                                  child: Text(getNameOfSort(sort)),
                                  value: sort,
                                ))
                            .toList(),
                        onChanged: (sort) {
                          model.sortWithProduct = sort;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        onPressed: () {
                          model.filterProducts();
                          Navigator.pop(context);
                        },
                        child: Text("Submit filter"),
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        onPressed: () {
                          model.clearDetails();
                          Navigator.pop(context);
                        },
                        child: Text("Clear filter"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
