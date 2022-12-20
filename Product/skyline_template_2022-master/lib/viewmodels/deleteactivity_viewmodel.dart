import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

import '../model/Activity.dart';

class DeleteActivityViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //Method removes an activity from a User's activityList
  void deleteActivity(Activity activity) async {
    await getLoggedInUser().removeActivity(activity);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await saveUser(getLoggedInUser(), prefs);
    print(getLoggedInUser().toJson());
    showDialog(
        context: locator<NavigationService>().navigationKey.currentContext,
        builder: (context) {
          return AlertDialog(
              title: Text('Activity Deleted'),
              content: Column(
                children: [
                  Text('Activity had been removed from user\'s account.'),
                  ElevatedButton(
                      onPressed: () {
                        routeToHubView();
                      },
                      child: Text('Return To Hub'))
                ],
              ));
        });
  }

  //Widget displays either an error message if user has no activities, or the correct view if they do.
  Widget getWidget() {
    if (getLoggedInUser().activityList.length == 0) {
      return Text('User has not created any Activities.');
    } else {
      return Column(
        children: <ElevatedButton>[
          for (int i = 0; i < getLoggedInUser().activityList.length; i++)
            ElevatedButton(
              onPressed: () {
                deleteActivity(getLoggedInUser().activityList[i]);
              },
              child: Text(getLoggedInUser().activityList[i].title),
            ),
        ],
      );
    }
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }
}
