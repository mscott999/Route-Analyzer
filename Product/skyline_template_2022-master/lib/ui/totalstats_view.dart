import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/totalstats_viewmodel.dart';

class TotalStatsView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalStatsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<TotalStatsViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false, title: Text("Route Analyzer")),
        body: viewModel.getWidget(),
      ),
    );
  }
}
