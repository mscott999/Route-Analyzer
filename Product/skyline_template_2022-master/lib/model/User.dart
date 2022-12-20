import 'Activity.dart';

//Class which represent a user of the app. Each user has a list of activities exclusive to them.
class User {
  DateTime startDateTime;
  List<Activity> activityList = [];
  String name;
  String _userName;
  String _password;

  //Constructor of user using minimum inputs, all other variables are created automatically.
  User(String name, String userName, String password) {
    this.name = name;
    this._userName = userName;
    this._password = password;
    this.startDateTime = DateTime.now();
  }

  //Method used to Add activities to ActivityList
  void addActivity(Activity activity) {
    activityList.add(activity);
    print(activityList.toString());
  }

  //Method used to Remove Activities from ActivityList
  void removeActivity(Activity activity) {
    for (int i = 0; i < activityList.length; i++) {
      if (activityList[i] == activity) {
        activityList.removeAt(i);
      }
    }
  }

  //Method to restore a user instance from a Map String.
  User.fromJson(Map<String, dynamic> json)
      : startDateTime = DateTime.parse(json['startDateTime']),
        //activityList = List<Activity>.from(json['activityList']),
        activityList = decodeActivityList(json['activityList']),
        name = json['name'],
        _userName = json['userName'],
        _password = json['password'];

  //Method to convert a user object into a Map, which essentially is a long string that represents the objects variables.
  Map<String, dynamic> toJson() {
    List<Map> activityList = this.activityList != null
        ? this.activityList.map((i) => i.toJson()).toList()
        : null;
    return {
      'startDateTime': startDateTime.toString(),
      'activityList': activityList,
      'name': name,
      'userName': _userName,
      'password': _password,
    };
  }

  //Method which converts a Json list to an Activity List, used in FromJson
  static List<Activity> decodeActivityList(List activityObjsJson) {
    print('decode activity list called');
    List<Activity> result = activityObjsJson
        .map((activityJson) => Activity.fromJson(activityJson))
        .toList();
    print('result parsed');
    return result;
  }

  //Getters used during the login process.
  String getUserName() {
    return _userName;
  }

  String getPassword() {
    return _password;
  }
}
