import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class SettingsScreenView extends StackedView<SettingsScreenModel>{
  @override
   SettingsScreenView({
    required this.apps,
    required this.ogApps,
    required this.categories,
    required this.fontColor,
    required this.backgroundColor,
    required this.selectedEntry,
    required this.isReturnButtonEnabled,
    super.key});

  List<Applications> apps;
  List<Applications> ogApps;
  List<Categories> categories;
  final Color fontColor;
  final Color backgroundColor;
  final int selectedEntry;
  final bool isReturnButtonEnabled;

  @override
  Widget builder(
      BuildContext context,
      SettingsScreenModel viewModel,
      Widget? child
      ){
    return PopScope(
      canPop: viewModel.isThemeSelection || viewModel.isTrackingListView || viewModel.isReturnButtonWindows ? false : true,
        onPopInvoked: (_){
          viewModel.isThemeSelection = false;
          viewModel.isTrackingListView = false;
          viewModel.isReturnButtonWindows = false;
          viewModel.notifyListeners();
        },
        child: Scaffold(
          resizeToAvoidBottomInset : false,
          body: Stack(
            children: [

              // Background Theme
              BackgroundTheme(viewModel: viewModel),

              // AppBar
              StoreAppBar(viewModel: viewModel),

              // Settings List
              if (!viewModel.isCategorySelected)
              SettingsList(viewModel: viewModel),

              // Theme Selector
              if (viewModel.isThemeSelection  && !viewModel.isCategorySelected)
                ThemeSelector(viewModel: viewModel),

              // Tracking List
              if (viewModel.isTrackingListView  && !viewModel.isCategorySelected)
                TrackingApps(viewModel: viewModel),

              // Return Button Selector
              if (viewModel.isReturnButtonWindows && !viewModel.isCategorySelected)
                ReturnButtonSelector(viewModel: viewModel),

              // Category Apps List
              if (viewModel.isCategorySelected)
                CategoryAppsList(viewModel: viewModel),

              // Return Button
              if (viewModel.isReturnButtonEnabled)
                OnDisplayReturnButton(viewModel: viewModel),

              // NavBar
              CustomizedNavBar(viewModel: viewModel,)

            ],
          ),
        ),
    );
  }

  @override
  SettingsScreenModel viewModelBuilder(BuildContext context) => SettingsScreenModel(fontColor: fontColor, backgroundColor: backgroundColor, apps: apps, selectedEntry: selectedEntry, isReturnButtonEnabled : isReturnButtonEnabled, ogApps: ogApps, categories: categories, isAppInit: false);
}