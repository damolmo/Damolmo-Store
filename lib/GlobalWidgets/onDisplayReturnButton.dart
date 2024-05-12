import 'package:flutter/material.dart';
import '../exports.dart';

class OnDisplayReturnButton extends StatelessWidget{
  @override
  const OnDisplayReturnButton({
    required this.viewModel,
    super.key});

  final dynamic viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.15,
      height: getDeviceHeight(context) * 0.07,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.8,
        right: getDeviceWidth(context) * 0.05,
        top: getDeviceHeight(context) * 0.78,
        bottom: getDeviceHeight(context) * 0.15
      ),
      decoration: BoxDecoration(
        color: viewModel.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(130),
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.5), blurRadius: 6.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)],
      ),
      child: IconButton(
        onPressed : (){
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios_rounded, color: viewModel.fontColor, size: 35,),
      ),
    );
  }
}