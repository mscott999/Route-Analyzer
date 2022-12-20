import 'package:gpx/gpx.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';

import '../model/Activity.dart';
import '../model/User.dart';

class TotalStatsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  //Necesary variables to display map.
  //This set starts as empty, but eventually contains all route polylines taht are to be displayed
  Set<Polyline> _polylines = Set<Polyline>();
  GoogleMapController mapController;

  //Either returns an error message if user has no activities, or map view if they do.
  Widget getWidget() {
    if (getLoggedInUser().activityList.length != 0) {
      return Column(
        children: [
          getMap(),
          Text(
            'Total Distance Biked:',
            textScaleFactor: 2,
          ),
          Text(
            getTotalDistance(),
            textScaleFactor: 1.5,
          ),
          Text(
            'Total Duration Biked:',
            textScaleFactor: 2,
          ),
          Text(
            getTotalDuration(),
            textScaleFactor: 1.5,
          ),
          Text(
            'Average Biking Speed:',
            textScaleFactor: 2,
          ),
          Text(
            getAverageSpeed(),
            textScaleFactor: 1.5,
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
          Row(), //Row is here to center the column by adding a max width element.
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            'User needs at least one added activity to display statistics.',
            textScaleFactor: 1.5,
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
          Row(), //Row is here to center the column by adding a max width element.
        ],
      );
    }
  }

  //Method returns a map.
  Widget getMap() {
    //This quick for loop fills up _polylines with each Activity's route line.
    _polylines.clear();
    for (int i = 0; i < getLoggedInUser().activityList.length; i++) {
      constructPolyline(getLoggedInUser().activityList[i]);
    }
    print('MAP BUILT');
    return SizedBox(
      height: 400,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          //target: LatLng(45.521563, -122.677433),
          target: LatLng(47.6645740, -122.0411640),
          zoom: 11.0,
        ),
        polylines: _polylines,
      ),
    );
  }

  //Used to convert an Activity to a display-able line
  void constructPolyline(Activity activity) {
    print('CONSTRUCT POLYLINE CALLED');
    List<LatLng> polylineLatLongs = [];
    String gpxString = activity.gpxContents;
    Gpx gpx = GpxReader().fromString(gpxString);

    //debug messages
    print('trks: ' + gpx.trks.length.toString());
    print('trksegs: ' + gpx.trks[0].trksegs.length.toString());
    print('trkpts: ' + gpx.trks[0].trksegs[0].trkpts.length.toString());

    for (int i = 0; i < gpx.trks.length; i++) {
      for (int j = 0; j < gpx.trks[i].trksegs.length; j++) {
        for (int k = 0; k < gpx.trks[i].trksegs[j].trkpts.length; k++) {
          polylineLatLongs.add(new LatLng(gpx.trks[i].trksegs[j].trkpts[k].lat,
              gpx.trks[i].trksegs[j].trkpts[k].lon));
          print('ITERATION DONE');
        }
      }
    }
    //debug message
    print(polylineLatLongs.toString());

    _polylines.add(Polyline(
        polylineId: PolylineId('0'),
        points: polylineLatLongs,
        color: Colors.blue,
        visible: true,
        width: 6));
    print(_polylines.toString());
  }

  //sets appropriate map controller
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Sums all activities' distances, and returns the string total
  String getTotalDistance() {
    User user = getLoggedInUser();
    double distanceSum = 0;
    for (int i = 0; i < user.activityList.length; i++) {
      distanceSum += user.activityList[i].distance;
    }
    distanceSum = double.parse((distanceSum).toStringAsFixed(2));
    return distanceSum.toString() + ' miles';
  }

  //Sums all activities' durations, and returns the string total
  String getTotalDuration() {
    User user = getLoggedInUser();
    int totalSeconds = 0;
    for (int i = 0; i < user.activityList.length; i++) {
      totalSeconds += user.activityList[i].duration.inSeconds;
    }
    Duration totalDuration = Duration(seconds: totalSeconds);
    List<String> splitDistance = totalDuration.toString().split('.');
    return splitDistance[0];
  }

  //Finds the average speed using total duration and total distance returns string.
  String getAverageSpeed() {
    User user = getLoggedInUser();
    double avgSpeed = 0;
    for (int i = 0; i < user.activityList.length; i++) {
      avgSpeed += user.activityList[i].avgerageSpeed;
    }
    avgSpeed /= user.activityList.length;
    avgSpeed = double.parse((avgSpeed).toStringAsFixed(2));
    return avgSpeed.toString() + ' miles per hour';
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }
}
