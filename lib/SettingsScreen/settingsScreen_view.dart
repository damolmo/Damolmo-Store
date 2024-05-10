import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class SettingsScreenView extends StackedView<SettingsScreenModel>{
  @override
  const SettingsScreenView({
    required this.apps,
    required this.isDarkModeEnabled,
    super.key});

  final bool isDarkModeEnabled;
  final List<Applications> apps;

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
  SettingsScreenModel viewModelBuilder(BuildContext context) => SettingsScreenModel(isDarkModeEnabled: isDarkModeEnabled, apps: apps);
}