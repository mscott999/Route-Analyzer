import 'package:skyline_template_app/viewmodels/addactivity_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/chooseactivity_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/compareactivities_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/deleteactivity_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/newuser_viewmodel.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:skyline_template_app/viewmodels/totalstats_viewmodel.dart';
import 'viewmodels/hub_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  _setupViewModels();
  _setupServices();
}

Future _setupViewModels() async {
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<HubViewModel>(() => HubViewModel());
  locator.registerLazySingleton<NewuserViewModel>(() => NewuserViewModel());
  locator.registerLazySingleton<AddActivityViewModel>(
      () => AddActivityViewModel());
  locator.registerLazySingleton<DeleteActivityViewModel>(
      () => DeleteActivityViewModel());
  locator
      .registerLazySingleton<TotalStatsViewModel>(() => TotalStatsViewModel());
  locator.registerLazySingleton<ChooseActivityViewModel>(
      () => ChooseActivityViewModel());
  locator.registerLazySingleton<CompareActivitiesViewModel>(
      () => CompareActivitiesViewModel());
}

Future _setupServices() async {
  locator
      .registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
}
