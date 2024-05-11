import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class DownloadsScreenView extends StackedView<DownloadsScreenModel>{
  @override
  const DownloadsScreenView({
    required this.fontColor,
    required this.backgroundColor,
    required this.apps,
    super.key
});

  final Color fontColor;
  final Color backgroundColor;
  final List<Applications> apps;

  @override
  Widget builder(
      BuildContext context,
      DownloadsScreenModel viewModel,
      Widget? child
      ){

    return Scaffold(
        resizeToAvoidBottomInset : false,
      body : Stack(
        children: [

          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          // App Bar
          StoreAppBar(viewModel: viewModel),

          // Pending List
            PendingList(viewModel: viewModel),

          // Nav Bar
          CustomizedNavBar(viewModel: viewModel),


        ],
      )
    );
  }

  @override
  DownloadsScreenModel viewModelBuilder(BuildContext context) => DownloadsScreenModel(fontColor: fontColor, backgroundColor: backgroundColor, apps: apps);



}