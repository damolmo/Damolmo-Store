import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class AppScreenView extends StackedView<AppScreenModel>{
  @override
  const AppScreenView({
    required this.app,
    super.key});

  final Applications app;

  @override
  Widget builder(
      BuildContext context,
      AppScreenModel viewModel,
      Widget? child
      ){

    viewModel.app = app;
    viewModel.notifyListeners();

    return Scaffold(
      body : Stack(
        children: [
          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          SingleChildScrollView(
            child: Stack(
              children: [

                // App Banner
                AppBanner(viewModel: viewModel),

                // App Details
                AppDetails(viewModel: viewModel),

                // App Screen
                AppScreen(viewModel: viewModel),

                // App Description
                AppDescription(viewModel: viewModel),

                // App Footer
                AppFooter(viewModel: viewModel),

              ],
            ),
          ),

          // App Bar
          StoreAppBar(viewModel: viewModel),

          // NavBar
          CustomizedNavBar(viewModel: viewModel)


        ],
                  )
    );
  }

  @override
  AppScreenModel viewModelBuilder(BuildContext context) => AppScreenModel();
}