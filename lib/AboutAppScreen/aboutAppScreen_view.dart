import 'package:damolmo_store/AboutAppScreen/widgets/aboutAppBanner.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class AboutAppScreenView extends StackedView<AboutAppScreenModel>{
  @override
  const AboutAppScreenView({
    required this.fontColor,
    required this.backgroundColor,
    required this.isReturnButtonEnabled,
    required this.uri,
    super.key,
});

  final String uri;
  final Color fontColor;
  final bool isReturnButtonEnabled;
  final Color backgroundColor;

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

          // About App Banner
          AboutAppBanner(viewModel: viewModel,),

          // about App List
          AboutAppList(viewModel: viewModel),

          // Floating Return button
          if (viewModel.isReturnButtonEnabled)
            OnDisplayReturnButton(viewModel: viewModel),

        ],
      )
    );
  }

  @override
  AboutAppScreenModel viewModelBuilder(BuildContext context) => AboutAppScreenModel(fontColor: fontColor, backgroundColor: backgroundColor, isReturnButtonEnabled : isReturnButtonEnabled, isAppInit: false, isCategorySelected: false, uri: uri, context: context);

}