import 'package:flutter/material.dart';
import '../../exports.dart';

class AppScreen extends StatelessWidget{
  @override
  const AppScreen({
    required this.viewModel,
    super.key
});

  final AppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.99,
      height: getDeviceHeight(context) * 0.5,
      margin: EdgeInsets.only(
         top: getDeviceHeight(context) * 0.6,
          bottom: getDeviceHeight(context) * 0.2

      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.appScreens.length ,
          itemBuilder: (context, index){
          return Container(
            height: getDeviceHeight(context) * 0.4,
            width: getDeviceWidth(context) * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(viewModel.appScreens[index].screenUri)
              )
            ),

          );
        },
      )
    );
  }

}