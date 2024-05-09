import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class DownloadsScreenView extends StackedView<DownloadsScreenModel>{
  @override
  const DownloadsScreenView({
    super.key
});

  @override
  Widget builder(
      BuildContext context,
      DownloadsScreenModel viewModel,
      Widget? child
      ){
    return Scaffold(
      body : Stack(
        children: [

        ],
      )
    );
  }

  @override
  DownloadsScreenModel viewModelBuilder(BuildContext context) => DownloadsScreenModel();



}