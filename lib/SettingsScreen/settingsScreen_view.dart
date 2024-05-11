import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class SettingsScreenView extends StackedView<SettingsScreenModel>{
  @override
  const SettingsScreenView({
    required this.apps,
    required this.fontColor,
    required this.backgroundColor,
    super.key});

  final List<Applications> apps;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget builder(
      BuildContext context,
      SettingsScreenModel viewModel,
      Widget? child
      ){
    return PopScope(
      canPop: viewModel.isThemeSelection || viewModel.isTrackingListView ? false : true,
        onPopInvoked: (_){
          viewModel.isThemeSelection = false;
          viewModel.isTrackingListView = false;
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
              SettingsList(viewModel: viewModel),

              // Theme Selector
              if (viewModel.isThemeSelection)
                ThemeSelector(viewModel: viewModel),

              // Tracking List
              if (viewModel.isTrackingListView)
                TrackingApps(viewModel: viewModel),

              // NavBar
              CustomizedNavBar(viewModel: viewModel,)

            ],
          ),
        ),
    );
  }

  @override
  SettingsScreenModel viewModelBuilder(BuildContext context) => SettingsScreenModel(fontColor: fontColor, backgroundColor: backgroundColor, apps: apps);
}