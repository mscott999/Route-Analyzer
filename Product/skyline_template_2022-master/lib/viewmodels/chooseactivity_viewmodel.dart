import 'package:flutter/material.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

class ChooseActivityViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  //Method returns a varaible number of button widgets to represent the user's number of Activities.
  Widget getWidget() {
    firstActivity = null;
    secondActivity = null;
    if (getLoggedInUser().activityList.length >= 2) {
      return Column(
        children: [
          Text(
            'Compare Two Activities',
            textScaleFactor: 3,
            textAlign: TextAlign.center,
          ),
          Text(
            'Please select first activity:',
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
          Column(
            children: <ElevatedButton>[
              //populate column algorithm.
              for (int i = 0; i < getLoggedInUser().activityList.length; i++)
                ElevatedButton(
                  onPressed: () {
                    firstActivity = getLoggedInUser().activityList[i];
                    print('firstChoice: ' +
                        getLoggedInUser().activityList[i].toJson().toString());
                  },
                  child: Text(getLoggedInUser().activityList[i].title),
                )
            ],
          ),
          Text(
            'Please select second activity:',
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
          Column(
            children: <ElevatedButton>[
              //populate column algorithm.
              for (int i = 0; i < getLoggedInUser().activityList.length; i++)
                ElevatedButton(
                  onPressed: () {
                    secondActivity = getLoggedInUser().activityList[i];
                    print('secondChoice: ' +
                        getLoggedInUser().activityList[i].toJson().toString());
                  },
                  child: Text(getLoggedInUser().activityList[i].title),
                )
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  submitChoices();
                },
                child: Text('Submit Selection'),
              )),
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  routeToHubView();
                },
                child: Text('Return'),
              )),
          Row() //Here just to center all elements in the column by adding a max-width widget
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            'User needs at least two added activities to compare.',
            textScaleFactor: 2,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  routeToHubView();
                },
                child: Text('Return'),
              )),
          Row() //Here just to center all elements in the column by adding a max-width widget
        ],
      );
    }
  }

  //Method checks if choice of Activities is valid. No empty choices or repeats
  void submitChoices() {
    if ((firstActivity == null) || (secondActivity == null)) {
      showDialog(
          context: locator<NavigationService>().navigationKey.currentContext,
          builder: (context) {
            return AlertDialog(
                title: Text('Insufficient Choices'),
                content: Column(
                  children: [
                    Text('An activity must be selected for both choices.'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Ok'))
                  ],
                ));
          });
    } else if (firstActivity == secondActivity) {
      showDialog(
          context: locator<NavigationService>().navigationKey.currentContext,
          builder: (context) {
            return AlertDialog(
                title: Text('Isufficient Choice'),
                content: Column(
                  children: [
                    Text(
                        'A different activity must be chosen for both choices.'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('ok'))
                  ],
                ));
          });
    } else {
      routeToCompareActivitiesView();
    }
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }

  void routeToCompareActivitiesView() {
    _navigationService.navigateTo(CompareActivitiesViewRoute);
  }
}
