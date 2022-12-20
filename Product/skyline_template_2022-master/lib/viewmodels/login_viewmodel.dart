import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/model/User.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  //Temporary, private variables used for input validation. They are updated whenever a textfield is changed.
  String currentUsername = '';
  String currentPassword = '';

  //Method checks to see if currentUsername == pre-existing user, or if password is valid. After, loggedInUsr is set to user, and routed to hub view
  void attemptLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(currentUsername) != null) {
      User targetUser = restoreUser(currentUsername, prefs);
      if ((currentUsername == targetUser.getUserName()) &&
          (currentPassword == targetUser.getPassword())) {
        setLoggedInUser(targetUser);
        print(getLoggedInUser().toJson());
        routeToHubView();
        setCurrentUsername('');
        setCurrentPassword('');
      } else {
        showDialog(
            context: locator<NavigationService>().navigationKey.currentContext,
            builder: (context) {
              return AlertDialog(
                title: Text('Incorrect Credentials'),
                content: Text('Username does not match password.'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'))
                ],
              );
            });
      }
    } else {
      showDialog(
          context: locator<NavigationService>().navigationKey.currentContext,
          builder: (context) {
            return AlertDialog(
              title: Text('Incorrect Credentials'),
              content: Text('Username does not match any existing user.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  void setCurrentUsername(String value) {
    currentUsername = value;
  }

  void setCurrentPassword(String value) {
    currentPassword = value;
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }

  void routeToNewuserView() {
    _navigationService.navigateTo(NewuserViewRoute);
  }
}
