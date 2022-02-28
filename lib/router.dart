import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grand_uae/admin/attribute/attributes_model.dart';
import 'package:grand_uae/admin/attribute/attributes_view.dart';
import 'package:grand_uae/admin/category/categories_model.dart';
import 'package:grand_uae/admin/category/cateogries_view.dart';
import 'package:grand_uae/admin/customer/customers_model.dart';
import 'package:grand_uae/admin/customer/customers_view.dart';
import 'package:grand_uae/admin/customer_group/customer_group_model.dart';
import 'package:grand_uae/admin/customer_group/customer_group_view.dart';
import 'package:grand_uae/admin/dashboard/dashboard_model.dart';
import 'package:grand_uae/admin/dashboard/dashboard_view.dart';
import 'package:grand_uae/admin/login/login_model.dart';
import 'package:grand_uae/admin/login/login_view.dart';
import 'package:grand_uae/admin/manufacture/manufracture_model.dart';
import 'package:grand_uae/admin/manufacture/manufracture_view.dart';
import 'package:grand_uae/admin/model/orders_response.dart' as AdminOrder;
import 'package:grand_uae/admin/order_details/order_details_model.dart';
import 'package:grand_uae/admin/order_details/order_details_view.dart';
import 'package:grand_uae/admin/orders/orders_model.dart';
import 'package:grand_uae/admin/orders/orders_view.dart';
import 'package:grand_uae/admin/products/products_model.dart';
import 'package:grand_uae/admin/products/products_view.dart';
import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/customer/about/about_page.dart';
import 'package:grand_uae/customer/address/shipping_address_model.dart';
import 'package:grand_uae/customer/address/shipping_address_view.dart';
import 'package:grand_uae/customer/cart/cart_model.dart';
import 'package:grand_uae/customer/cart/cart_view.dart';
import 'package:grand_uae/customer/category/category_list.dart';
import 'package:grand_uae/customer/category/category_model.dart';
import 'package:grand_uae/customer/category/category_products.dart';
import 'package:grand_uae/customer/contact_us/contact_us_view.dart';
import 'package:grand_uae/customer/country_selection/country_view.dart';
import 'package:grand_uae/customer/customer_details/customer_details_model.dart';
import 'package:grand_uae/customer/customer_details/customer_details_view.dart';
import 'package:grand_uae/customer/forgotpassword/forgot_password_model.dart';
import 'package:grand_uae/customer/forgotpassword/forgot_password_view.dart';
import 'package:grand_uae/customer/home/home_model.dart';
import 'package:grand_uae/customer/home/home_view.dart';
import 'package:grand_uae/customer/login/login_model.dart';
import 'package:grand_uae/customer/login/login_view.dart';
import 'package:grand_uae/customer/login/push_notification/push_notification_login_model.dart';
import 'package:grand_uae/customer/login/push_notification/push_notification_login_view.dart';
import 'package:grand_uae/customer/model/category_response.dart';
import 'package:grand_uae/customer/model/order.dart';
import 'package:grand_uae/customer/model/send_time_slot.dart';
import 'package:grand_uae/customer/model/social_links.dart';
import 'package:grand_uae/customer/payment/payment_model.dart';
import 'package:grand_uae/customer/payment/payment_view.dart';
import 'package:grand_uae/customer/place_order/place_order_model.dart';
import 'package:grand_uae/customer/place_order/place_order_view.dart';
import 'package:grand_uae/customer/product/cart_product_model.dart';
import 'package:grand_uae/customer/product_compare/product_compare_model.dart';
import 'package:grand_uae/customer/product_compare/product_compare_view.dart';
import 'package:grand_uae/customer/product_details/product_details.dart';
import 'package:grand_uae/customer/product_details/product_details_model.dart';
import 'package:grand_uae/customer/profile/address/add_address_model.dart';
import 'package:grand_uae/customer/profile/address/add_address_view.dart';
import 'package:grand_uae/customer/profile/address_list/address_list_model.dart';
import 'package:grand_uae/customer/profile/address_list/address_list_view.dart';
import 'package:grand_uae/customer/profile/change_password/change_password_model.dart';
import 'package:grand_uae/customer/profile/change_password/change_password_view.dart';
import 'package:grand_uae/customer/profile/details/details_model.dart';
import 'package:grand_uae/customer/profile/details/details_view.dart';
import 'package:grand_uae/customer/profile/edit_address/edit_address_model.dart';
import 'package:grand_uae/customer/profile/edit_address/edit_address_view.dart';
import 'package:grand_uae/customer/profile/order_history/order_details_view.dart';
import 'package:grand_uae/customer/profile/order_history/order_history_model.dart';
import 'package:grand_uae/customer/profile/order_history/order_history_view.dart';
import 'package:grand_uae/customer/profile/profile_view.dart';
import 'package:grand_uae/customer/profile/profile_view_model.dart';
import 'package:grand_uae/customer/push_notification/push_notification_model.dart';
import 'package:grand_uae/customer/push_notification/push_notification_view.dart';
import 'package:grand_uae/customer/register/register_view.dart';
import 'package:grand_uae/customer/search/search_model.dart';
import 'package:grand_uae/customer/search/search_view.dart';
import 'package:grand_uae/customer/splash/splash_model.dart';
import 'package:grand_uae/customer/splash/splash_view.dart';
import 'package:grand_uae/customer/startup/startup_view.dart';
import 'package:grand_uae/customer/time_slot/time_slot_model.dart';
import 'package:grand_uae/customer/time_slot/time_slot_view.dart';
import 'package:grand_uae/customer/wishlist/wishlist_model.dart';
import 'package:grand_uae/customer/wishlist/wishlist_view.dart';
import 'package:provider/provider.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.AddressRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => ShippingAddressViewModel(context),
          child: ShippingAddressView(),
        ),
      );
    case routes.EditUserDetailRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => DetailModel(),
          child: DetailsView(),
        ),
      );
    case routes.ShowAddressListRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => AddressListModel(),
          child: AddressListView(),
        ),
      );
    case routes.EditAddressRoute:
      var addressId = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => EditAddressModel(addressId),
          child: EditAddressView(),
        ),
      );
    case routes.UserDetailsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => CustomerDetailsModel(),
          child: CustomerDetailsView(),
        ),
      );
    case routes.AboutRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AboutView(),
      );
    case routes.ContactUsRoute:
      ContactUs contactUs = settings.arguments as ContactUs;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ContactUsView(contactUs),
      );
    case routes.WishListRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => WishListModel(),
          child: WishListView(),
        ),
        routeName: settings.name,
      );
    case routes.SubCategoryRoute:
      var category = settings.arguments as Category;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => CategoryModel(category.categoryId),
          child: CategoryWithProducts(),
        ),
      );
    case routes.CompareProductsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ProductCompareModel(),
          child: ProductCompareView(),
        ),
      );
    case routes.HomePageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => HomeModel(
            Provider.of<CartProductModel>(
              context,
              listen: false,
            ),
          ),
          child: HomeView(),
        ),
      );
    case routes.RegisterRoute:
      return _getPageRoute(
        viewToShow: RegisterView(),
        routeName: settings.name,
      );

    case routes.ForgotPasswordRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => ForgotPasswordModel(),
          child: ForgotPasswordView(),
        ),
        routeName: settings.name,
      );
    case routes.CountrySelectionRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CountrySelectionView(),
      );
    case routes.StartupRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUpView(),
      );
    case routes.SplashRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => SplashModel(),
          child: SplashView(),
        ),
      );

    case routes.ProductDetailsRoute:
      final String productId = settings.arguments as String;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ProductDetailsModel(productId),
          child: ProductDetailsView(),
        ),
      );
    case routes.CartDetailsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (context) => CartModel(
            context,
            Provider.of<CartProductModel>(
              context,
              listen: false,
            ),
          ),
          child: CartView(),
        ),
      );
    case routes.SearchRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => SearchModel(),
          child: SearchView(),
        ),
      );
    case routes.ProfileRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ProfileModel(),
          child: ProfileView(),
        ),
      );
    case routes.AddAddressRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => AddAddressModel(),
          child: AddAddressView(),
        ),
      );
    case routes.ChangePasswordRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ChangePasswordModel(),
          child: ChangePassword(),
        ),
      );
    case routes.PaymentRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => ChoosePaymentViewModel(),
          child: ChoosePaymentView(),
        ),
        routeName: settings.name,
      );
    case routes.PlaceOrderRoute:
      var selectedTimeSlot = settings.arguments as SelectTimeSlot;
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => PlaceOrderModel(selectedTimeSlot),
          child: PlaceOrderView(),
        ),
        routeName: settings.name,
      );
    case routes.TimeSlotRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => TimeSlotModel(),
          child: TimeSlotView(),
        ),
        routeName: settings.name,
      );
    case routes.OrderHistoryRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => OrderHistoryModel(),
          child: OrderHistoryView(),
        ),
      );
    case routes.OrderDetailsRoute:
      Order order = settings.arguments as Order;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: OrderDetailsView(order),
      );
    case routes.LoginRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => LoginModel(),
          child: LoginView(),
        ),
        routeName: settings.name,
      );
    case routes.PushNotificationLoginRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => PushNotificationLoginModel(),
          child: PushNotificationLoginView(),
        ),
        routeName: settings.name,
      );
    case routes.PushNotificationRoute:
      return _getPageRoute(
        viewToShow: ChangeNotifierProvider(
          create: (_) => PushNotificationModel(),
          child: PushNotificationView(),
        ),
        routeName: settings.name,
      );
    case routes.CategoryListRoute:
      final List<Category> categories = settings.arguments as List<Category>;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CategoryListView(categories),
      );

    /**
   * Admin Pages
   *
   * */
    case routes.DashboardRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => DashboardModel(),
          child: DashboardView(),
        ),
      );
    case routes.AdminLoginRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => AdminLoginModel(),
          child: AdminLoginView(),
        ),
      );
    case routes.CustomerManageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => CustomersModel(),
          child: CustomersView(),
        ),
      );
    case routes.CustomerGroupRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => CustomerGroupModel(),
          child: CustomerGroupView(),
        ),
      );
    case routes.ManufactureRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ManufacturesModel(),
          child: ManufactureView(),
        ),
      );
    case routes.CategoryManageRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => CategoriesModel(),
          child: CategoriesView(),
        ),
      );
    case routes.AttributeRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => AttributesModel(),
          child: AttributesView(),
        ),
      );
    case routes.AdminOrdersRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => OrdersModel(),
          child: OrdersView(),
        ),
      );
    case routes.AdminOrderDetailsRoute:
      AdminOrder.Order order = settings.arguments as AdminOrder.Order;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => AdminOrderDetailsModel(order),
          child: AdminOrderDetailsView(),
        ),
      );
    case routes.AdminProductsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ChangeNotifierProvider(
          create: (_) => ProductsModel(),
          child: ProductsView(),
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
