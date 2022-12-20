import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/compareactivities_viewmodel.dart';

class CompareActivitiesView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompareActivitiesViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<CompareActivitiesViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
              automaticallyImplyLeading: false, title: Text("Route Analyzer")),
          body: Column(
            children: [
              viewModel.getStatistics(),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.routeToHubView();
                    },
                    child: Text('Return'),
                  )),
              Row()
            ],
          )),
    );
  }
}
