import 'package:flutter/material.dart';
import '../../exports.dart';

class TrackingApps extends StatelessWidget{
  @override
  const TrackingApps({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.8,
      height: getDeviceHeight(context) * 0.6,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context) * 0.1,
        top: getDeviceHeight(context) * 0.2,
        bottom: getDeviceHeight(context) * 0.2,
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 10.0, spreadRadius: 3.0)],
        borderRadius: BorderRadius.circular(25),
        color: viewModel.backgroundColor.withOpacity(0.8)
      ),
      child: ListView.builder(
          itemCount: viewModel.tracking.length,
          itemBuilder: (context, index){
            return Container(
            width: getDeviceWidth(context) * 0.7,
            height: getDeviceHeight(context) * 0.15,
              margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.025,
                left: getDeviceWidth(context) * 0.05,
               right: getDeviceWidth(context) * 0.05),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), spreadRadius: 3.0, blurRadius: 6.0, blurStyle: BlurStyle.normal)],
                borderRadius: BorderRadius.circular(25),
                color: viewModel.backgroundColor.withOpacity(0.8)
              ),
              child: ListTile(
                leading: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6))]),child : Image.asset(viewModel.tracking[index].appIcon),),
                title: Text(viewModel.tracking[index].appName, style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.04),),
                subtitle: Text(viewModel.tracking[index].appVersion, style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.035),),
                trailing: IconButton(onPressed :(){viewModel.removeSelectedAppFromTracking(viewModel.tracking[index]);}, icon: const Icon(Icons.remove_circle_rounded, color: Colors.red, size: 40,),)


              ),
            );
          },
      )
    );
  }

}