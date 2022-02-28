import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/customer/model/cart_item.dart';
import 'package:grand_uae/customer/model/cart_products_response.dart';
import 'package:grand_uae/customer/model/product.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/product/product_item.dart';
import 'package:grand_uae/customer/product_details/product_details_model.dart';
import 'package:grand_uae/customer/views/cart_menu_item_tracker.dart';
import 'package:grand_uae/customer/views/color_circular_indicator.dart';
import 'package:grand_uae/customer/views/network_product_image.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/customer/views/search_icon.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:grand_uae/util/strings.dart';
import 'package:grand_uae/validators.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsModel>(
      builder: (_, model, Widget child) {
        if (model.state == ViewState.Busy) {
          return Material(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    Text("Loading details."),
                  ],
                ),
              ),
            ),
          );
        }
        if (model.state == ViewState.Error) {
          return Material(
            child: RetryButton(
              errorMessage:
                  model.errorMessage ?? "Error loading product details",
              onPressed: () {
                model.fetchProductDetails();
              },
            ),
          );
        }

        Product product = model.product;
        LocalCartProduct cartProduct = LocalCartProduct(
          product.productId,
          0,
        );
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: NetworkProductImage(
                          imageUrl: product.image,
                          isBoxFitContain: false,
                        ),
                      ),
                      SizedBox(
                        height: 72,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                floating: false,
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    tooltip: "Add to wishlist",
                    icon: model.isFavourite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    onPressed: () async => model.addToWishlist(),
                  ),
                  SearchIcon(),
                  CartMenuItemTracker(),
                  SizedBox(width: 8),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          product.name.toHtmlUnescapeCapitalize(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "${product.price}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Text(
                            'Details'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        product.description.isEmpty
                            ? Container()
                            : Text(
                                product.description.toHtmlUnescapeCapitalize(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                        SizedBox(
                          height: 12,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Brands: ",
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.subtitle2.color,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                text: product.manufacturer == null
                                    ? "N/a"
                                    : "${product.manufacturer.toLowerCase().firstLetterToUpperCase()}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Product Code: ",
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.subtitle2.color,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                text: product.manufacturer == null
                                    ? "N/a"
                                    : "${product.productId}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Availability: ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle2.color,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: product.stockStatus == null
                                    ? "N/a"
                                    : "${stockStatusValues.reverse[product.stockStatus]}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Ex. Tax.: ",
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle2.color,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: product.price == null
                                    ? "N/a"
                                    : "${product.price}",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          child: Consumer<CartProductModel>(
                            builder: (context, model, child) {
                              cartProduct.quantity = model.value.firstWhere(
                                  (e) => e.productId == cartProduct.productId,
                                  orElse: () {
                                return cartProduct;
                              }).quantity;
                              if (cartProduct.quantity == 0) {
                                return MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 32,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: Theme.of(context).accentColor,
                                  onPressed: () async {
                                    var success = await model.checkLoginOrNot();
                                    if (success) {
                                      cartProduct.quantity += 1;
                                      model.addCartProducts(cartProduct);
                                    }
                                  },
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cartProduct.quantity -= 1;
                                      model.addCartProducts(cartProduct);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Theme.of(context).accentColor,
                                      size: 32,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${cartProduct.quantity ?? 0}",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cartProduct.quantity += 1;
                                      model.addCartProducts(cartProduct);
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: Theme.of(context).accentColor,
                                      size: 32,
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        OutlineButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () async {
                            final result = await model.addToCompare(
                              product.productId,
                            );
                            if (result) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} added to compare',
                                  ),
                                  action: SnackBarAction(
                                    onPressed: () {
                                      model.navigateToCompare();
                                    },
                                    label: "Compare",
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Compare product",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        _similarProducts(context),
                        _reviews(context),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Consumer<CartProductModel>(
            builder: (_, cartModel, Widget child) {
              if (cartModel.value.isNotEmpty) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    cartModel.clearCart();
                  },
                  label: Text(
                    cartModel.isLoading
                        ? "Adding items to cart"
                        : "Place order",
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
      },
    );
  }

  _reviews(BuildContext context) {
    return Consumer<ProductDetailsModel>(
      builder: (_, model, child) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  "Reviews (${model.reviews.length})".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              (model.reviews == null || model.reviews.isEmpty)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("No reviews yet."),
                      ),
                    )
                  : Container(),
              ListView.separated(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.reviews.length,
                itemBuilder: (_, index) {
                  var review = model.reviews[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        review.author,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconTheme(
                        data: IconThemeData(
                          color: Colors.amber,
                          size: 16,
                        ),
                        child: StarDisplay(
                          value: int.parse(review.rating),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        review.text ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => Divider(),
              ),
              Divider(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  "Add Review".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: validateReview,
                controller: model.textController,
                decoration: InputDecoration(
                  labelText: 'Review',
                  hintText: 'Enter review',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // RatingBar(
              //   glow: false,
              //   initialRating: 3,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   allowHalfRating: false,
              //   itemCount: 5,
              //   itemPadding: EdgeInsets.symmetric(
              //     horizontal: 4.0,
              //   ),
              //   itemBuilder: (context, _) => Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (current) {
              //     model.rating = current;
              //   },
              // ),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledColor: Colors.grey,
                padding: const EdgeInsets.all(16),
                onPressed: model.state == ViewState.Idle
                    ? () async {
                        if (_formKey.currentState.validate()) {
                          model.addReview();
                        }
                      }
                    : null,
                color: Theme.of(context).accentColor,
                child: model.state == ViewState.Idle
                    ? Text(
                        "Add review",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Colors.grey[600],
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 1000,
              )
            ],
          ),
        );
      },
    );
  }

  _similarProducts(BuildContext context) {
    return Consumer<ProductDetailsModel>(
      builder: (_, model, child) {
        if (model.similarProducts == null || model.similarProducts.isEmpty) {
          return Container();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Similar Products",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Container(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: model.similarProducts.length,
                itemBuilder: (_, index) {
                  var product = model.similarProducts[index];
                  return ProductItem(product);
                },
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;

  const StarDisplayWidget({
    Key key,
    this.value = 0,
    @required this.filledStar,
    @required this.unfilledStar,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key key, int value = 0})
      : super(
          key: key,
          value: value,
          filledStar: const Icon(Icons.star),
          unfilledStar: const Icon(Icons.star_border),
        );
}
