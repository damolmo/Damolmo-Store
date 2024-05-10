import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class AppScreenView extends StackedView<AppScreenModel>{
  @override
  const AppScreenView({
    required this.app,
    required this.isDarkModeEnabled,
    super.key});

  final Applications app;
  final bool isDarkModeEnabled;

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

                  ],
                ),
              ),

              // App Bar
              StoreAppBar(viewModel: viewModel),

              // Category Search
              if (viewModel.isCategorySelected)
                CategoryAppsList(viewModel: viewModel),

              // NavBar
              CustomizedNavBar(viewModel: viewModel)


            ],
          )
        ),
    );
  }

  @override
  AppScreenModel viewModelBuilder(BuildContext context) => AppScreenModel(app: app);
}