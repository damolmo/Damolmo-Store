import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class AppScreenView extends StackedView<AppScreenModel>{
  @override
  AppScreenView({
    required this.app,
    required this.ogApps,
    required this.categories,
    required this.apps,
    required this.fontColor,
    required this.backgroundColor,
    required this.isReturnButtonEnabled,
    required this.uri,
    super.key});

  final String uri;
  final Applications app;
  final List<Applications> apps;
  List<Categories> categories;
  List<Applications> ogApps;
  final Color fontColor;
  final Color backgroundColor;
  final bool isReturnButtonEnabled;

  @override
  Widget builder(
      BuildContext context,
      AppScreenModel viewModel,
      Widget? child
      ){

      return PopScope(
      canPop: viewModel.isCategorySelected ? false : true,
        onPopInvoked: (_){
        viewModel.isCategorySelected = false;
        viewModel.notifyListeners();
        },
        child: Scaffold(
            resizeToAvoidBottomInset : false,
          body : Stack(
            children: [
              // Background Theme
              BackgroundTheme(viewModel: viewModel),

              SingleChildScrollView(
                child: Stack(
                  children: [

                    // App Banner
                    if (!viewModel.isCategorySelected)
                      AppBanner(viewModel: viewModel),

                    // App Details
                    if (!viewModel.isCategorySelected)
                      AppDetails(viewModel: viewModel),

                    // App Screen
                    if (!viewModel.isCategorySelected)
                      AppScreen(viewModel: viewModel),

                    // App Description
                    if (!viewModel.isCategorySelected)
                      AppDescription(viewModel: viewModel),

                    // App Footer
                    if (!viewModel.isCategorySelected)
                      AppFooter(viewModel: viewModel),

                    // Category Apps List
                    if (viewModel.isCategorySelected)
                      CategoryAppsList(viewModel: viewModel),

                  ],
                ),
              ),

              // App Bar
              StoreAppBar(viewModel: viewModel),

              // Return Button
              if (viewModel.isReturnButtonEnabled)
                OnDisplayReturnButton(viewModel: viewModel),

              // NavBar
              CustomizedNavBar(viewModel: viewModel)


            ],
          )
        ),
    );
  }

  @override
  AppScreenModel viewModelBuilder(BuildContext context) => AppScreenModel(app: app, fontColor: fontColor, backgroundColor: backgroundColor, apps: apps, isReturnButtonEnabled : isReturnButtonEnabled, ogApps: ogApps, categories: categories, isAppInit: false, uri: uri, context: context);
}