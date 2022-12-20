import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/router.dart' as router;
import 'locator.dart';
import 'model/Activity.dart';
import 'model/User.dart';
import 'ui/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

//User instance which represents the currently logged in user.
User _loggedInUser;
//List of all recognized files in "inportfiles".
List<File> gpxList = [];
//Activities chosen for comparison, needed to be global level.
Activity firstActivity;
Activity secondActivity;
String contents;

//Start of app, first process to run.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  updateGpxList();
  setupLocator();
  runApp(RouteAnalyzer());
}

//Core StatelessWidget of the app, is constantly displayed.
class RouteAnalyzer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) =>
          router.Router.generateRoute(context, settings),
      title: 'Route Analyzer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginView(),
    );
  }
}

//Methods to change and recieve what user is logged in.
void setLoggedInUser(User user) {
  _loggedInUser = user;
}

User getLoggedInUser() {
  return _loggedInUser;
}

//Method used to save/update a user's information to SharedPreferences, and is saved locally.
void saveUser(User user, SharedPreferences prefs) async {
  String json = jsonEncode(user.toJson());
  prefs.setString(user.getUserName(), json);
}

//Method used to restore a user instance from its SharedPreference key.
User restoreUser(String userName, SharedPreferences prefs) {
  Map<String, dynamic> json = jsonDecode(prefs.getString(userName));
  return User.fromJson(json);
}

//Updates fileList of what is in"inportfiles"
void updateGpxList() async {
  await gpxList.clear();
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap =
      json.decode(manifestContent.toString());
  final gpxPaths = manifestMap.keys
      .where((String key) => key.contains('importfiles/'))
      .where((String key) => key.contains('.gpx'))
      .toList();
  for (int i = 0; i < gpxPaths.length; i++) {
    gpxList.add(new File(gpxPaths[i]));
  }
  print(gpxList.toString());
}

//Used to read from files.
void readFileContent(String filePath) async {
  String response = await rootBundle.loadString(filePath);
  contents = response;
}
