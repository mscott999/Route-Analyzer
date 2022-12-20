import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

import '../main.dart';
import '../model/User.dart';

class NewuserViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  //Temporary, local variables, they are updated whenever the tetfeilds are changed
  String currentName = '';
  String currentUsername = '';
  String currentPassword = '';
  String currentConfirmPassword = '';

  //Method first runs conditionals to check if input is valid, and then either displays error message, or creates a new user
  void createNewUser() async {
    print('Name: ' + currentName);
    print('username: ' + currentUsername);
    print('password: ' + currentPassword);
    print('confirmPassword: ' + currentConfirmPassword);
    if ((currentName.length >= 1) &&
        (currentUsername.length >= 4) &&
        (currentPassword.length >= 4) &&
        (currentConfirmPassword.length >= 4)) {
      if (currentPassword == currentConfirmPassword) {
        setLoggedInUser(
            new User(currentName, currentUsername, currentPassword));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        saveUser(getLoggedInUser(), prefs);
        print(restoreUser(currentUsername, prefs).toJson());
        routeToHubView();
      } else {
        showDialog(
            context: locator<NavigationService>().navigationKey.currentContext,
            builder: (context) {
              return AlertDialog(
                title: Text('Incorrect Credentials'),
                content: Text('Passwords must match in both textfields.'),
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
              title: Text('Incomplete Credentials'),
              content:
                  Text('All fields must be at least four characters long.'),
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

  void setCurrentName(String value) {
    currentName = value;
  }

  void setCurrentUsername(String value) {
    currentUsername = value;
  }

  void setCurrentPassword(String value) {
    currentPassword = value;
  }

  void setCurrentConfirmPassword(String value) {
    currentConfirmPassword = value;
  }

  void routeToLoginView() {
    _navigationService.navigateTo(LoginViewRoute);
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }
}
