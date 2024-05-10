import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class AboutAppScreenView extends StackedView<AboutAppScreenModel>{
  @override
  const AboutAppScreenView({
    required this.isDarkModeEnabled,
    super.key,
});
  final bool isDarkModeEnabled;

  @override
  Widget builder(
      BuildContext context,
      AboutAppScreenModel viewModel,
      Widget? child
      ){
    return Scaffold(
      body : Stack(
        children: [

          // Background Theme
          BackgroundTheme(viewModel: viewModel),

        ],
      )
    );
  }

  @override
  AboutAppScreenModel viewModelBuilder(BuildContext context) => AboutAppScreenModel();

}