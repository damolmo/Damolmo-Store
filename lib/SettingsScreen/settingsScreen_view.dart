import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class SettingsScreenView extends StackedView<SettingsScreenModel>{
  @override
  const SettingsScreenView({super.key});

  @override
  Widget builder(
      BuildContext context,
      SettingsScreenModel viewModel,
      Widget? child
      ){
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Stack(
        children: [

          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          // AppBar
          StoreAppBar(viewModel: viewModel),

          // NavBar
          CustomizedNavBar(viewModel: viewModel,)

        ],
      ),
    );
  }

  @override
  SettingsScreenModel viewModelBuilder(BuildContext context) => SettingsScreenModel();
}