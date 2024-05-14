import 'package:flutter/material.dart';
import '../../exports.dart';

class AboutAppBanner extends StatelessWidget{
  @override
  const AboutAppBanner({
    required this.viewModel,
    super.key
});

  final AboutAppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.7 : getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.2,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.15 : getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.15 : getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.05,
        bottom: getDeviceHeight(context) * 0.75
      ),
      child: Row(
        children: [
          // App Icon
          Container(
            width: getDeviceWidth(context) * 0.25,
            margin: EdgeInsets.only(
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/logo/logo.png")
              )
            ),
          ),

          // App Text
          Container(
            width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.45 : getDeviceWidth(context) * 0.65,
            child: Text("Damolmo Store", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.05 : getDeviceWidth(context) * 0.09, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }

}