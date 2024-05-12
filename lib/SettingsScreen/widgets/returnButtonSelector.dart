import 'package:flutter/material.dart';
import '../../exports.dart';

class ReturnButtonSelector extends StatelessWidget{
  @override
  const ReturnButtonSelector({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build (BuildContext context){
    return Container(
      width: getDeviceWidth(context) *  0.8,
      height: getDeviceHeight(context) * 0.6,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context) * 0.1,
        top: getDeviceHeight(context) * 0.2,
        bottom: getDeviceHeight(context) * 0.2
      ),
      decoration: BoxDecoration(
        color: viewModel.backgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
      ),
      child: Column(
        children: [
          // Text Banner
          Container(
            height: getDeviceHeight(context) * 0.15,
            width: getDeviceWidth(context) * 0.5,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.05,
              right: getDeviceWidth(context) * 0.05,
              bottom: getDeviceHeight(context) * 0.05,
              top: getDeviceHeight(context) * 0.025
            ),
            child: Row(
              children: [
                // Banner icon
                Container(
                  width: getDeviceWidth(context) * 0.15,
                  margin: EdgeInsets.only(
                    right: getDeviceWidth(context) * 0.05
                  ),
                  child: Icon(Icons.radio_button_checked_rounded, color: viewModel.fontColor, size: 45,),
                ),

                // Banner text
                SizedBox(
                  width: getDeviceWidth(context) * 0.3,
                  child: Text("Floating Return Button", style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.045), textAlign: TextAlign.left,),
                ),
              ],
            ),
          ),

          // Selector
          Container(
            height: getDeviceHeight(context) * 0.35,
            width: getDeviceWidth(context) * 0.6,
            margin: EdgeInsets.only(
              bottom: getDeviceHeight(context) * 0.025
            ),
            child: Column(
              children: [
                // Enabled Button
                InkWell(
                  onTap : (){
                    viewModel.isReturnButtonWindows = false;
                    viewModel.setDisplayButton("enabled");
                    viewModel.restartApp();
                    viewModel.notifyListeners();
                  },
                  child : Container(
                  width: getDeviceWidth(context) * 0.55,
                  height: getDeviceHeight(context) * 0.15,
                  margin: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.025,
                    right: getDeviceWidth(context) * 0.025,
                    bottom: getDeviceHeight(context) * 0.015
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: viewModel.fontColor, blurRadius: 6.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)],
                    color: viewModel.backgroundColor,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text("Enable", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold),),
                      const Spacer(),
                    ],
                  ),
                  ),
                ),

                // Disable Button
                    InkWell(
                      onTap : (){
                      viewModel.isReturnButtonWindows = false;
                      viewModel.setDisplayButton("disabled");
                      viewModel.restartApp();
                      viewModel.notifyListeners();
                      },
                     child :Container(
                      width: getDeviceWidth(context) * 0.55,
                      height: getDeviceHeight(context) * 0.15,
                      margin: EdgeInsets.only(
                          top: getDeviceHeight(context) * 0.02,
                          left: getDeviceWidth(context) * 0.025,
                          right: getDeviceWidth(context) * 0.025,
                          bottom: getDeviceHeight(context) * 0.015
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: viewModel.fontColor, blurRadius: 6.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)],
                          color: viewModel.backgroundColor,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          Text("Disable", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold),),
                          const Spacer(),
                        ],
                      ),
                     ),
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}