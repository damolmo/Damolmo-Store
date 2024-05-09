import 'package:flutter/material.dart';
import '../exports.dart';

class BackgroundTheme extends StatelessWidget{
  @override
  const BackgroundTheme({
    required this.viewModel,
    super.key
});

  final viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context),
      height: getDeviceHeight(context),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled? Colors.black: Colors.white
      ),
    );
  }

}