import 'package:flutter/material.dart';
import '../../exports.dart';

class PendingList extends StatelessWidget{
  @override
  const PendingList({
    required this.viewModel,
    super.key
});

  final DownloadsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.95,
      height: getDeviceHeight(context) * 0.7,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.025,
        right: getDeviceWidth(context) * 0.025,
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceHeight(context) * 0.15
      ),
      child: viewModel.pending.isNotEmpty ? ListView.builder(
          itemCount: viewModel.pending.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
               viewModel.navigateToAppPage(context, viewModel.getApp(viewModel.pending[index].appName, context));
              },
                child : Container(
                  width: getDeviceWidth(context) * 0.9,
                  height: getDeviceHeight(context) * 0.12,
                  margin: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.025,
                    right: getDeviceWidth(context) * 0.025,
                    top: getDeviceHeight(context) * 0.03
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 10.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
                    borderRadius: BorderRadius.circular(15),
                    color: viewModel.backgroundColor
                  ),
                  child: ListTile(
                    leading: Image.asset(viewModel.pending[index].appIcon),
                    title: Text(viewModel.pending[index].appName, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.04, fontWeight: FontWeight.bold),) ,
                    subtitle: Text(viewModel.pending[index].appVersion, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.035)),
                    trailing: IconButton(onPressed : (){ viewModel.getApp(viewModel.pending[index].appName, context); },icon: Icon(Icons.arrow_forward_ios_rounded, color: viewModel.fontColor,),),
                  ),
                ),
            );
          }
      ) :  Text("\n\nNo Updates available!\nCheck Again Later :D", style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.center,),
    );
  }

}