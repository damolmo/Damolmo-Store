import 'package:flutter/material.dart';
import '../../exports.dart';

class AppFooter extends StatelessWidget{
  @override
  const AppFooter({
    required this.viewModel,
    super.key
});

  final AppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context),
      height: getDeviceHeight(context) * 0.8,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 1.7,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.appDetailsStr.length,
          itemBuilder: (context, index){
            return Container(
              width: getDeviceWidth(context),
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) * 0.01,
                right: getDeviceWidth(context) * 0.01,
                top: getDeviceHeight(context) * 0.02
              ),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 4.0, spreadRadius: 3.0)],
                color: viewModel.backgroundColor
              ),
              child: ListTile(
                leading: Icon(viewModel.appDetailsIcons[index], color: viewModel.fontColor, size: getDeviceWidth(context) > 580 ? 25 : 35,),
                title: Text(viewModel.appDetailsStr[index], style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ? getDeviceWidth(context) * 0.025 : getDeviceWidth(context) * 0.05, fontWeight:  FontWeight.bold),),
                trailing: Text(viewModel.appDetailsValues[index], style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ? getDeviceWidth(context) * 0.015 : getDeviceWidth(context) * 0.03),),
              ),
            );
          }
      )
    );
  }

}