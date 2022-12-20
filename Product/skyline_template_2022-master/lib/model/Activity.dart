//Class which represents a bike ride, or "activity". important statistics are saved as doubles, GPX contents saved as string
class Activity {
  String gpxContents;
  DateTime activityDateTime;
  String title;
  Duration duration;
  double distance;
  double avgerageSpeed;
  double elevationChange;
  double averageHeartRate;

  Activity(String title, String dateString, String gpxContents, String distance,
      String duration) {
    this.gpxContents = gpxContents;
    this.title = title;
    this.activityDateTime = DateTime.parse(dateString);
    this.distance = double.parse(distance);
    List<String> splitDistanceString = duration.split(';');
    this.duration = new Duration(
        hours: int.parse(splitDistanceString[0]),
        minutes: int.parse(splitDistanceString[1]),
        seconds: int.parse(splitDistanceString[2]));
    double rawTime = this.duration.inSeconds.toDouble();
    rawTime /= 3600;
    this.avgerageSpeed = this.distance / rawTime;
  }

  //Method used to restore an Activity file from a Map String.

  Activity.fromJson(Map<String, dynamic> json)
      : activityDateTime = DateTime.parse(json['activityDateTime']),
        gpxContents = json['gpxContents'],
        title = json['title'],
        duration = durationFromString(json['duration']),
        distance = json['distance'],
        avgerageSpeed = json['averageSpeed'],
        elevationChange = json['elevationChange'],
        averageHeartRate = json['averageHeartRate'];

  //Method to convert an Activity object into a Map, which essentially is a long string that represents the object and its variables.
  Map<String, dynamic> toJson() => {
        'activityDateTime': activityDateTime.toString(),
        'gpxContents': gpxContents,
        'title': title,
        'duration': duration.toString(),
        'distance': distance,
        'averageSpeed': avgerageSpeed,
        'elevationChange': elevationChange,
        'averageHeartRate': averageHeartRate,
      };

  static Duration durationFromString(String string) {
    List<String> timeList = string.split(':');
    List<String> secondList = timeList[2].split('.');
    return new Duration(
        hours: int.parse(timeList[0]),
        minutes: int.parse(timeList[1]),
        seconds: int.parse(secondList[0]));
  }
}
