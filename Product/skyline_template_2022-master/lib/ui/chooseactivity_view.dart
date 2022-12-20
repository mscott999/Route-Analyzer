import 'package:flutter/material.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/chooseactivity_viewmodel.dart';

class ChooseActivityView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChooseActivityViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<ChooseActivityViewModel>(),
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
