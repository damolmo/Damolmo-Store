import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../exports.dart';

class LeaveScreen extends StatelessWidget{
  @override
  const LeaveScreen({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.8,
      height: getDeviceHeight(context) * 0.3,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context)  * 0.1,
        top: getDeviceHeight(context) * 0.35,
        bottom: getDeviceHeight(context) * 0.35
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 20.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
        borderRadius: BorderRadius.circular(25),
        color: viewModel.backgroundColor.withOpacity(0.8)
      ),
      child: Column(
        children: [
          // Leave Message
          Container(
            height: getDeviceHeight(context) * 0.07,
            width: getDeviceWidth(context) * 0.5,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025,
              bottom: getDeviceHeight(context) * 0.025,
              left: getDeviceWidth(context) * 0.15,
              right: getDeviceWidth(context) * 0.15
            ),
            child: Text("Exit Store?", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.06, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),

          // Leave Buttons
          InkWell(
            onTap: (){
              viewModel.isExitAllowed = true;
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              viewModel.notifyListeners();
            },
            child : Container(
              height: getDeviceHeight(context) * 0.15,
              width: getDeviceWidth(context) * 0.6,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) * 0.1,
                right: getDeviceWidth(context) * 0.1,
                bottom: getDeviceHeight(context) * 0.025
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red
              ),
              child: Column(
                children: [
                  const Spacer(),
                 Text("Close", style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.07), textAlign: TextAlign.center,),
                  const Spacer(),
                 ],
               )
            ),
            ),
        ],
      ),
    );
  }
}