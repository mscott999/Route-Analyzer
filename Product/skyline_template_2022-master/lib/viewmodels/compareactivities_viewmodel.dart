import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import 'package:skyline_template_app/main.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import '../model/Activity.dart';

class CompareActivitiesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  GoogleMapController mapController;
  Set<Polyline> _polylines = Set<Polyline>();

  //method returns the stats spread below the map
  Widget getStatistics() {
    return Column(
      children: [
        getMap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              firstActivity.title,
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              secondActivity.title,
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
        Text(
          'Total Distance',
          textScaleFactor: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getDistanceStat(firstActivity),
            getDistanceStat(secondActivity),
          ],
        ),
        Text(
          'Total Duration',
          textScaleFactor: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getDurationStat(firstActivity),
            getDurationStat(secondActivity),
          ],
        ),
        Text(
          'Average Speed',
          textScaleFactor: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getSpeedStat(firstActivity),
            getSpeedStat(secondActivity),
          ],
        ),
      ],
    );
  }

  //Method returns the distance stat of an activity in the correct color coordination in refrence to its ranking
  Widget getDistanceStat(Activity activity) {
    TextStyle textStyle;
    Activity againstActivity;
    if (activity == firstActivity) {
      againstActivity = secondActivity;
    } else {
      againstActivity = firstActivity;
    }
    if (activity.distance > againstActivity.distance) {
      textStyle = TextStyle(color: Colors.green);
    } else if (activity.distance == againstActivity.distance) {
      textStyle = TextStyle(color: Color.fromARGB(255, 138, 127, 32));
    } else {
      textStyle = TextStyle(color: Colors.red);
    }
    return Text(
      activity.distance.toStringAsFixed(2) + ' mi',
      textScaleFactor: 1.5,
      style: textStyle,
    );
  }

// same as above, but for duration instead
  Widget getDurationStat(Activity activity) {
    TextStyle textStyle;
    Activity againstActivity;
    if (activity == firstActivity) {
      againstActivity = secondActivity;
    } else {
      againstActivity = firstActivity;
    }
    if (activity.duration.compareTo(againstActivity.duration) < 0) {
      textStyle = TextStyle(color: Colors.green);
    } else if (activity.duration.compareTo(againstActivity.duration) == 0) {
      textStyle = TextStyle(color: Color.fromARGB(255, 138, 127, 32));
    } else {
      textStyle = TextStyle(color: Colors.red);
    }
    List<String> tempDuration = activity.duration.toString().split('.');
    return Text(
      tempDuration[0],
      textScaleFactor: 1.5,
      style: textStyle,
    );
  }

// same again, but for speed
  Widget getSpeedStat(Activity activity) {
    TextStyle textStyle;
    Activity againstActivity;
    if (activity == firstActivity) {
      againstActivity = secondActivity;
    } else {
      againstActivity = firstActivity;
    }
    if (activity.avgerageSpeed > againstActivity.avgerageSpeed) {
      textStyle = TextStyle(color: Colors.green);
    } else if (activity.avgerageSpeed == againstActivity.avgerageSpeed) {
      textStyle = TextStyle(color: Color.fromARGB(255, 138, 127, 32));
    } else {
      textStyle = TextStyle(color: Colors.red);
    }
    return Text(
      activity.avgerageSpeed.toStringAsFixed(2) + ' mph',
      textScaleFactor: 1.5,
      style: textStyle,
    );
  }

  //This giant widget produces the map on the screen
  Widget getMap() {
    _polylines.clear();
    constructPolyline1(firstActivity);
    constructPolyline2(secondActivity);
    print('MAP BUILT');
    return SizedBox(
      height: 350,
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

  //Method actually turns GPX route into a display-able line
  void constructPolyline1(Activity activity) {
    print('CONSTRUCT POLYLINE CALLED');
    List<LatLng> polylineLatLongs = [];
    String gpxString = activity.gpxContents;
    Gpx gpx = GpxReader().fromString(gpxString);
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

  //Same as last polyline constructor, but different color for activity 2
  void constructPolyline2(Activity activity) {
    print('CONSTRUCT POLYLINE CALLED');
    List<LatLng> polylineLatLongs = [];
    String gpxString = activity.gpxContents;
    Gpx gpx = GpxReader().fromString(gpxString);
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
        color: Colors.orange,
        visible: true,
        width: 6));
    print(_polylines.toString());
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void routeToHubView() {
    _navigationService.navigateTo(HubViewRoute);
  }
}
