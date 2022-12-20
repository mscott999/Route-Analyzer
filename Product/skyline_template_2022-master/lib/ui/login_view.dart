import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<LoginViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false, title: Text("Route Analyzer")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 200.0,
                bottom: 8.0,
              ),
              child: Text(
                "Login",
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String value) {
                  viewModel.setCurrentUsername(value);
                  //print('username: ' + viewModel.currentUsername);
                },
                decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String value) {
                  viewModel.setCurrentPassword(value);
                  //print('password: ' + viewModel.currentPassword);
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.attemptLogin();
                    },
                    child: Text('Sign In'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.routeToNewuserView();
                    },
                    child: Text('New User'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
