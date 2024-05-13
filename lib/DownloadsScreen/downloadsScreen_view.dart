import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class DownloadsScreenView extends StackedView<DownloadsScreenModel>{
  @override
  DownloadsScreenView({
    required this.fontColor,
    required this.backgroundColor,
    required this.apps,
    required this.ogApps,
    required this.categories,
    required this.selectedEntry,
    required this.isReturnButtonEnabled,
    super.key
});

  final bool isReturnButtonEnabled;
  final Color fontColor;
  final Color backgroundColor;
  final List<Applications> apps;
  List<Applications> ogApps;
  List<Categories> categories;
  final int selectedEntry;

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

          // Switch Button
          if (!viewModel.isCategorySelected)
          SwitchButtons(viewModel: viewModel),

          // Pending List
          if (!viewModel.isCategorySelected && !viewModel.isDownloadsScreen)
            PendingList(viewModel: viewModel),

          // Category Apps List
          if (viewModel.isCategorySelected)
            CategoryAppsList(viewModel: viewModel),

          // Downloads List
          if (viewModel.isDownloadsScreen && !viewModel.isCategorySelected)
            DownloadsList(viewModel: viewModel),

          // Return Button
          if (viewModel.isReturnButtonEnabled)
            OnDisplayReturnButton(viewModel: viewModel),

          // Nav Bar
          CustomizedNavBar(viewModel: viewModel),


        ],
      )
    );
  }

  @override
  DownloadsScreenModel viewModelBuilder(BuildContext context) => DownloadsScreenModel(fontColor: fontColor, backgroundColor: backgroundColor, apps: apps, selectedEntry: selectedEntry, isReturnButtonEnabled : isReturnButtonEnabled, ogApps: ogApps, categories: categories, isAppInit: false);



}