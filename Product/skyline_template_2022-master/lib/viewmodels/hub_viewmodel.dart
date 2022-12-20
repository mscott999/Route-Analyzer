import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

class HubViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void routeToLoginView() {
    _navigationService.navigateTo(LoginViewRoute);
  }

  void routeToAddActivityView() {
    _navigationService.navigateTo(AddActivityViewRoute);
  }

  void routeToChooseActivityView() {
    _navigationService.navigateTo(ChooseActivityViewRoute);
  }

  void routeToTotalStatsView() {
    _navigationService.navigateTo(TotalStatsViewRoute);
  }

  void routeToDeleteActivityView() {
    _navigationService.navigateTo(DeleteActivityViewRoute);
  }
}
