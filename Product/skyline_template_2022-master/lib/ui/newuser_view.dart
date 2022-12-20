import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/newuser_viewmodel.dart';

class NewuserView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewuserViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<NewuserViewModel>(),
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
                top: 180.0,
                bottom: 8.0,
              ),
              child: Text(
                "Register New User",
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String value) {
                  viewModel.setCurrentName(value);
                  print('Full Name: ' + viewModel.currentName);
                },
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String value) {
                  viewModel.setCurrentUsername(value);
                  print('username: ' + viewModel.currentUsername);
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
                  print('password: ' + viewModel.currentPassword);
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String value) {
                  viewModel.setCurrentConfirmPassword(value);
                  print('confirmPassword: ' + viewModel.currentConfirmPassword);
                },
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
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
                      viewModel.createNewUser();
                    },
                    child: Text('Confirm'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        viewModel.routeToLoginView();
                      },
                      child: Text('Return')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
