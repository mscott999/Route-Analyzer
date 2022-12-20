import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

import '../model/Activity.dart';

class AddActivityViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String _currentTitle;
  String _currentDistance;
  String _currentDuration;
  String _currentDate;

  //Method is called after selecting a file. A chain of conditionals is ran to determine if an activity can be made, before making one
  void selectFile(File gpxFile) {
    readFileContent(gpxFile.path);
    showDialog(
        context: locator<NavigationService>().navigationKey.currentContext,
        builder: (context) {
          return AlertDialog(
              title: Text('Activity Title'),
              content: Column(
                children: [
                  Text('Please initialize the activity.'),
                  TextField(
                    onChanged: (String value) {
                      _currentTitle = value;
                      print('currentTitle: ' + _currentTitle);
                    },
                    decoration: InputDecoration(
                        hintText: 'Title:',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  TextField(
                    onChanged: (String value) {
                      _currentDate = value;
                      print('currentDate: ' + _currentDate);
                    },
                    decoration: InputDecoration(
                        hintText: 'Date (YYYY-MM-DD):',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  TextField(
                    onChanged: (String value) {
                      _currentDistance = value;
                      print('currentDistance: ' + _currentDistance);
                    },
                    decoration: InputDecoration(
                        hintText: 'Distance (miles):',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  TextField(
                    onChanged: (String value) {
                      _currentDuration = value;
                      print('currentDuration: ' + _currentDuration);
                    },
                    decoration: InputDecoration(
                        hintText: 'Duration (hr;m;s)',
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if ((_currentTitle != null) &&
                                (_currentTitle.isEmpty == false) &&
                                (_currentDate != null) &&
                                (_currentDate.isEmpty == false) &&
                                (_currentDistance != null) &&
                                (_currentDistance.isEmpty == false) &&
                                (_currentDuration != null) &&
                                (_currentDuration.isEmpty == false)) {
                              if (DateTime.tryParse(_currentDate) != null) {
                                if (double.tryParse(_currentDistance) != null) {
                                  try {
                                    Duration _test =
                                        durationFromString(_currentDuration);
                                    print(_test);
                                  } catch (e) {
                                    showDialog(
                                        context: locator<NavigationService>()
                                            .navigationKey
                                            .currentContext,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text('Incorrect Format'),
                                              content: Column(
                                                children: [
                                                  Text(
                                                      'Please enter distance using h/m/s.'),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Ok'))
                                                ],
                                              ));
                                        });
                                  }
                                  Activity addedActivity = new Activity(
                                      _currentTitle,
                                      _currentDate,
                                      contents,
                                      _currentDistance,
                                      _currentDuration);
                                  getLoggedInUser().addActivity(addedActivity);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  saveUser(getLoggedInUser(), prefs);
                                  print(getLoggedInUser().toJson());
                                  routeToHubView();
                                } else {
                                  showDialog(
                                      context: locator<NavigationService>()
                                          .navigationKey
                                          .currentContext,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text('Incorrect Format'),
                                            content: Column(
                                              children: [
                                                Text(
                                                    'Please enter a valid number for distance'),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Ok'))
                                              ],
                                            ));
                                      });
                                }
                              } else {
                                showDialog(
                                    context: locator<NavigationService>()
                                        .navigationKey
                                        .currentContext,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text('Incorrect Format'),
                                          content: Column(
                                            children: [
                                              Text(
                                                  'Please use YYYY-MM-DD with dashes for date.'),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok'))
                                            ],
                                          ));
                                    });
                              }
                            } else {
                              showDialog(
                                  context: locator<NavigationService>()
                                      .navigationKey
                                      .currentContext,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text('Missing Information'),
                                        content: Column(
                                          children: [
                                            Text('All fields must be filled.'),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Ok'))
                                          ],
                                        ));
                                  });
                            }
                          },
                          child: Text('Submit')),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Return'),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }

  //Method borrowed from Activity.dart, used in try catch to check for errors
  static Duration durationFromString(String string) {
    List<String> timeList = string.split(':');
    List<String> secondList = timeList[2].split('.');
    return new Duration(
        hours: int.parse(timeList[0]),
        minutes: int.parse(timeList[1]),
        seconds: int.parse(secondList[0]));
  }

  void routeToLoginView() {
    _navigationService.navigateTo(LoginViewRoute);
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }
}
