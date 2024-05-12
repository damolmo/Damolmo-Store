import 'package:flutter/material.dart';
import '../../exports.dart';

class AboutAppList extends StatelessWidget{
  @override
  AboutAppList({
    required this.viewModel,
    super.key
});

  final AboutAppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      height: getDeviceHeight(context) * 0.6,
      width: getDeviceWidth(context) * 0.9,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.3,
        bottom: getDeviceHeight(context) * 0.1,
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05
      ),
      child: ListView.builder(
          itemCount: viewModel.aboutTitleString.length,
          itemBuilder: (context, index){
            return Container(
              width: getDeviceWidth(context) * 0.85,
              height: getDeviceHeight(context) * 0.12,
              margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.025,
                left: getDeviceWidth(context) * 0.025,
                right: getDeviceHeight(context) * 0.025
              ),
              decoration: BoxDecoration(
                color: viewModel.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
              ),
              child: ListTile(
                leading: Icon(viewModel.aboutIcons[index], size: 45, color: viewModel.fontColor,),
                title: Text(viewModel.aboutTitleString[index], style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05), textAlign: TextAlign.left,),
                subtitle: Text(viewModel.aboutSubtitleString[index], style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.03), textAlign: TextAlign.left,),
              ),
            );
    },
    )
    );
  }

}