import 'package:grand_uae/constants/route_paths.dart' as routes;
import 'package:grand_uae/locator.dart';
import 'package:grand_uae/viewmodels/base_model.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateTo(String route) {
    _navigationService.navigateTo(route);
  }

  void navigateToUserDetail() {
    _navigationService.navigateTo(
      routes.EditUserDetailRoute,
    );
  }
}
