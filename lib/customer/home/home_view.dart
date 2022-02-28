import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grand_uae/constants/constants.dart' as links;
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/category/category_items.dart';
import 'package:grand_uae/customer/enums/connectivity_status.dart';
import 'package:grand_uae/customer/home/banner_carousel.dart';
import 'package:grand_uae/customer/home/home_model.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/product/hot_selling_products.dart';
import 'package:grand_uae/customer/product/latest_products.dart';
import 'package:grand_uae/customer/product/popular_products.dart';
import 'package:grand_uae/customer/views/cart_menu_item_tracker.dart';
import 'package:grand_uae/customer/views/color_circular_indicator.dart';
import 'package:grand_uae/customer/views/error_network.dart';
import 'package:grand_uae/customer/views/retry_button.dart';
import 'package:grand_uae/enums/view_state.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeModel, ConnectivityStatus>(
      builder: (_, model, connectivityModel, child) {
        if (connectivityModel == ConnectivityStatus.Offline) {
          return NoInternet();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                showSimpleNotification(Text("Hello there!"));
              },
              child: SizedBox(
                child: Image.asset(
                  "images/grand_logo.png",
                  color: Theme.of(context).appBarTheme.iconTheme.color,
                ),
                width: 50,
              ),
            ),
            bottom: PreferredSize(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        model.navigateToSearch();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Icon(Icons.search),
                              ),
                              Text('Search products and more.'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              preferredSize: Size(double.infinity, 48),
            ),
            actions: <Widget>[
              CartMenuItemTracker(),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          drawer: buildDrawer(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Consumer<CartProductModel>(
            builder: (_, cartModel, child) {
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
          body: buildRefreshIndicator(model),
        );
      },
    );
  }

  buildRefreshIndicator(HomeModel model) {
    if (model.state == ViewState.Busy) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (model.state == ViewState.Error) {
      return RetryButton(
        errorMessage: model.errorMessage ??
            "Something wrong loading home, please try again!",
        onPressed: () {
          model.loadHomeDetails(false);
        },
      );
    }
    return RefreshIndicator(
      onRefresh: () async => model.loadHomeDetails(true),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          BannerCarousalImages(),
          CategoriesView(),
          LatestProducts(),
          PopularProducts(),
          HotSellingProducts(),
          SizedBox(
            height: 72,
          ),
        ],
      ),
    );
  }

  buildDrawer(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (_, model, child) {
        return Drawer(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).canvasColor),
                accountName: Text(
                  "Grand Hyper Market",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                accountEmail: Text(
                  model.countryName ?? "-",
                  style: Theme.of(context).textTheme.caption,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).canvasColor,
                  child: Image.asset("images/grand_logo.png"),
                ),
              ),
              /* ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateToAdminLogin();
                },
                leading: Icon(Icons.person),
                title: Text("Admin"),
              ),*/
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateToLogin();
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateToWishlist();
                },
                leading: Icon(Icons.favorite),
                title: Text("Wish list"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateToProductCompare();
                },
                leading: Icon(Icons.compare_arrows),
                title: Text("Compare"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateToContactUs(
                    model.social.contactUs,
                  );
                },
                leading: Icon(Icons.contact_phone),
                title: Text("Contact Us"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  model.navigateTo(routes.AboutRoute);
                },
                leading: Icon(Icons.info),
                title: Text("About"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<CartProductModel>().value.clear();
                  model.logout();
                },
                leading: Icon(Icons.launch),
                title: Text("Logout"),
              ),
              SizedBox(
                height: 16,
              ),
              model.social != null
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.twitter,
                                color: Colors.lightBlue,
                              ),
                              onPressed: () async {
                                if (await canLaunch(links.TwitterUrl)) {
                                  launch(model.social.twitter);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.youtube,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                if (await canLaunch(links.YouTubeUrl)) {
                                  launch(model.social.youtube);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue[700],
                              ),
                              onPressed: () async {
                                if (await canLaunch(links.FaceBookUrl)) {
                                  launch(model.social.facebook);
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.pink,
                              ),
                              onPressed: () async {
                                if (await canLaunch(links.InstagramUrl)) {
                                  launch(model.social.instagram);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
