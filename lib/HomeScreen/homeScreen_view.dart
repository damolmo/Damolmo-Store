import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class HomeScreenView extends StackedView<HomeScreenModel>{
  @override
   HomeScreenView({
    super.key});


  @override
  Widget builder(
      BuildContext context,
      HomeScreenModel viewModel,
      Widget? child
      ){

    return PopScope(
      canPop: viewModel.isCategorySelected || !viewModel.isExitAllowed ? false : true,
        onPopInvoked: (_){
          viewModel.exitCount+=1;
          if (viewModel.isCategorySelected){
            viewModel.exitCount = 0;
            viewModel.isCategorySelected = false;
          }

            if (viewModel.exitCount >= 1) {
              viewModel.showExitPopUp
                  ? viewModel.showExitPopUp = false
                  : viewModel.showExitPopUp = true;
              viewModel.exitCount = 0;
            }
            viewModel.notifyListeners();
          },
        child:Scaffold(
          resizeToAvoidBottomInset : false,
          body : Stack(
          children: [
            // Background Theme
            BackgroundTheme(viewModel: viewModel),

            // AppBar
            StoreAppBar(viewModel : viewModel),

            // Categories List
            if (!viewModel.isCategorySelected)
            CategoryApps(viewModel: viewModel),

            // Suggested Banner
            if (!viewModel.isCategorySelected)
              SuggestedAppsBanner(viewModel: viewModel),

            // Category Apps List
            if (viewModel.isCategorySelected)
              CategoryAppsList(viewModel: viewModel),

            // Exit Dialog
            if (viewModel.showExitPopUp)
              LeaveScreen(viewModel: viewModel),

            // NavBar
            CustomizedNavBar(viewModel: viewModel,),

          ],
          )
        ),
    );
  }

  @override
  HomeScreenModel viewModelBuilder(BuildContext context) => HomeScreenModel();
}