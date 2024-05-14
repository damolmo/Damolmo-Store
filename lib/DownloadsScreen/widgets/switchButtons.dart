import 'package:flutter/material.dart';
import '../../exports.dart';

class SwitchButtons extends StatelessWidget{
  @override
  const SwitchButtons({
    required this.viewModel,
    super.key
});

  final DownloadsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.5 : getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.1,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceHeight(context) * 0.7,
        left: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.25 : getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.25 : getDeviceWidth(context) * 0.05
      ),
      child: Row(
        children: [
          // Pending Button
          InkWell(
            onTap :(){
              viewModel.isDownloadsScreen = false;
              viewModel.notifyListeners();
            },
            child : Container(
              width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.15 : getDeviceWidth(context) * 0.3,
              height: getDeviceHeight(context) * 0.07,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.062 : getDeviceWidth(context) *  0.125,
                right: getDeviceWidth(context) * 0.05,
                top: getDeviceHeight(context) * 0.015,
                bottom: getDeviceHeight(context) * 0.015
              ),
              decoration: BoxDecoration(
                color: !viewModel.isDownloadsScreen ? viewModel.backgroundColor.withOpacity(0.6) : viewModel.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 4.0, spreadRadius: 2.0)]
              ),
              child: Row(
                children: [
                  const Spacer(),
                  Text("Updates", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.02 : getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold),),
                  const Spacer(),
                ],
              )
            ),
          ),

          // Downloads Button
          InkWell(
            onTap : (){
              viewModel.isDownloadsScreen = true;
              viewModel.notifyListeners();
            },
            child : Container(
            width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.15 : getDeviceWidth(context) * 0.3,
            height: getDeviceHeight(context) * 0.07,
            margin: EdgeInsets.only(
                right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.042 : getDeviceWidth(context) * 0.125,
                top: getDeviceHeight(context) * 0.015,
                bottom: getDeviceHeight(context) * 0.015
            ),
            decoration: BoxDecoration(
                color: viewModel.isDownloadsScreen ? viewModel.backgroundColor.withOpacity(0.6) : viewModel.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 4.0, spreadRadius: 2.0)]
            ),
            child: Row(
              children: [
                const Spacer(),
                Text("Downloads", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.02 : getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold),),
                const Spacer(),
              ],
            ),
            )
          ),
        ],
      ),
    );
  }

}