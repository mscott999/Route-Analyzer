import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/main.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/hub_viewmodel.dart';

class HubView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<HubViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<HubViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
              automaticallyImplyLeading: false, title: Text("Route Analyzer")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      viewModel.routeToAddActivityView();
                    },
                    child: Text('Add New Activity'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      viewModel.routeToChooseActivityView();
                    },
                    child: Text('Compare Acivities'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      viewModel.routeToTotalStatsView();
                    },
                    child: Text('Total Accumuated Statistics'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      viewModel.routeToDeleteActivityView();
                    },
                    child: Text('Delete Activity'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setLoggedInUser(null);
                      viewModel.routeToLoginView();
                    },
                    child: Text('Sign out'),
                  ),
                ),
                Row(), //Row is just here to make the column take up all of the horizontal space, so that it can be properly centered
              ],
            ),
          )),
    );
  }
}
