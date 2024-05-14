import 'package:flutter/material.dart';
import '../../exports.dart';

class AppBanner extends StatelessWidget{
  @override
  const AppBanner({
    required this.viewModel,
    super.key
});

  final AppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context),
      height: getDeviceHeight(context) * 0.25,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceHeight(context) * 0.025
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: getDeviceWidth(context) > 580 ? BoxFit.fitWidth : BoxFit.fill,
          image: AssetImage(viewModel.app.appBanner)
        ),
        borderRadius: BorderRadius.circular(2)
      ),
    );
  }

}