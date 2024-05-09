import 'package:flutter/material.dart';
import '../exports.dart';

class CustomizedNavBar extends StatelessWidget{
  @override
  const CustomizedNavBar({
    required this.viewModel,
    super.key
});

  final viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.1,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        bottom: getDeviceHeight(context) * 0.025,
        top: getDeviceHeight(context) * 0.875
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1), blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
        borderRadius: BorderRadius.circular(25),
        color: viewModel.isDarkModeEnabled ? Colors.black.withOpacity(0.6) : Colors.white
      ),
      child : Row(
        children: [
          // Home Button
          InkWell(
            onTap: (){
              viewModel.navigateToRoute(context, "home");
              viewModel.isDarkModeEnabled? viewModel.isDarkModeEnabled = false : viewModel.isDarkModeEnabled = true;
              viewModel.notifyListeners();
            },
            child : Container(
              width : getDeviceWidth(context) * 0.25,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) * 0.025,
                right: getDeviceWidth(context) * 0.05
              ),
              child: Column(
                children: [
                  // Route Icon
                  const Icon(Icons.category_rounded, color: Colors.orange, size: 45,),

                  // Route Name
                  Row(
                    children: [
                      const Spacer(),
                      Text("Categories", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                      const Spacer(),
                    ],
                  )
                ],
              )
            ),
          ),


          // Downloads Button
          // Home Button
          InkWell(
            onTap: (){
              //viewModel.navigateToRoute(context, "downloads");
            },
            child : Container(
                width : getDeviceWidth(context) * 0.25,
                height: getDeviceHeight(context) * 0.1,
                margin: EdgeInsets.only(
                    right: getDeviceWidth(context) * 0.05
                ),
                child: Column(
                  children: [
                    // Route Icon
                    const Icon(Icons.download_rounded, color: Colors.lightBlueAccent, size: 45,),

                    // Route Name
                    Row(
                      children: [
                        const Spacer(),
                        Text("Downloads", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    )
                  ],
                )
            ),
          ),

          // Settings Button
          // Home Button
          InkWell(
            onTap: (){
              //viewModel.navigateToRoute(context, "settings");
            },
            child : Container(
                width : getDeviceWidth(context) * 0.25,
                height: getDeviceHeight(context) * 0.1,
                margin: EdgeInsets.only(
                    right: getDeviceWidth(context) * 0.025
                ),
                child: Column(
                  children: [
                    // Route Icon
                    const Icon(Icons.settings_rounded, color: Colors.lightGreen, size: 45,),

                    // Route Name
                    Row(
                      children: [
                        const Spacer(),
                        Text("Settings", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    )
                  ],
                )
            ),
          ),
        ],
      )
    );
  }

}