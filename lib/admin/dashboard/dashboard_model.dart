import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class DashboardModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateCategory() {
    navigateTo(routes.CategoryManageRoute);
  }

  void navigateManufacturer() {
    navigateTo(routes.ManufactureRoute);
  }

  void navigateCustomer() {
    navigateTo(routes.CustomerManageRoute);
  }

  void navigateCustomerGroup() {
    navigateTo(routes.CustomerGroupRoute);
  }

  void navigateTo(String route) {
    _navigationService.navigateTo(route);
  }

  void navigateAttributes() {
    navigateTo(routes.AttributeRoute);
  }

  void navigateOrders() {
    navigateTo(routes.AdminOrdersRoute);
  }

  void navigateProducts() {
    navigateTo(routes.AdminProductsRoute);
  }
}
