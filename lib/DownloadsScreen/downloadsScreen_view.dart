import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class DownloadsScreenView extends StackedView<DownloadsScreenModel>{
  @override
  const DownloadsScreenView({
    required this.isDarkModeEnabled,
    super.key
});

  final bool isDarkModeEnabled;

  @override
  Widget builder(
      BuildContext context,
      DownloadsScreenModel viewModel,
      Widget? child
      ){

    return Scaffold(
        resizeToAvoidBottomInset : false,
      body : Stack(
        children: [

          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          // App Bar
          StoreAppBar(viewModel: viewModel),

          // Pending List
            PendingList(viewModel: viewModel),

          // Nav Bar
          CustomizedNavBar(viewModel: viewModel),


        ],
      )
    );
  }

  @override
  DownloadsScreenModel viewModelBuilder(BuildContext context) => DownloadsScreenModel(isDarkModeEnabled: isDarkModeEnabled);



}