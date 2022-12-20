import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/deleteactivity_viewmodel.dart';

class DeleteActivityView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteActivityViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<DeleteActivityViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false, title: Text("Route Analyzer")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Which Activity Will Be Deleted?',
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //populate column algorithm.
                  viewModel.getWidget(),
                ],
              ),
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.routeToHubView();
                  },
                  child: Text('Return'),
                )),
            Row(), //Row is just here to make the column take up all of the horizontal space, so that it can be properly centered
          ],
        ),
      ),
    );
  }
}
