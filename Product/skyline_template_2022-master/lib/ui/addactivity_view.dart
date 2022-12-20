import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../main.dart';
import '../viewmodels/addactivity_viewmodel.dart';

class AddActivityView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddActivityViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<AddActivityViewModel>(),
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
                'Which GPX file will be used for this activity?',
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <ElevatedButton>[
                  //populate column algorithm.
                  for (int i = 0; i < gpxList.length; i++)
                    ElevatedButton(
                      onPressed: () {
                        viewModel.selectFile(gpxList[i]);
                      },
                      child: Text(gpxList[i].path),
                    )
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
