import 'package:flutter/material.dart';
import '../../exports.dart';

class AppDescription extends StatelessWidget{
  @override
  const AppDescription({
    required this.viewModel,
    super.key
});

  final AppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      height: getDeviceHeight(context) * 0.5,
      width: getDeviceWidth(context),
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.01,
        right: getDeviceWidth(context) * 0.01,
        top: getDeviceHeight(context) * 1.15,
        bottom: getDeviceHeight(context) * 0.2
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled? Colors.black : Colors.white,
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4), blurRadius: 6.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)]
      ),
      child: ListView(
        children : [
          Text(viewModel.app.appDescription, style: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.05), textAlign: TextAlign.left,)]),

    );
  }

}