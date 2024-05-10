import 'package:flutter/material.dart';
import '../../exports.dart';

class ThemeSelector extends StatelessWidget{
  @override
  const ThemeSelector({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.6,
      height: getDeviceHeight(context) * 0.4,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.3,
        bottom: getDeviceHeight(context) * 0.3,
        right: getDeviceWidth(context) * 0.2,
        left: getDeviceWidth(context) * 0.2
      ),
      decoration: BoxDecoration(
        color: viewModel.isDarkModeEnabled?  Colors.black.withOpacity(0.8) : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurRadius: 10.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)]
      ),
      child: Column(
        children: [
          // Themes Windows Banner
          Container(
            width: getDeviceWidth(context) * 0.5,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025,
              bottom: getDeviceHeight(context) * 0.025,
              left: getDeviceWidth(context) * 0.05,
              right: getDeviceWidth(context) * 0.05,
            ),
            child: Row(
              children: [
                // Theme Icon
                Container(
                  width: getDeviceWidth(context) * 0.2,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.025
                  ),
                  child: Icon(Icons.palette, color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, size: 45,),
                ),

                // Theme Text
                Container(
                  width: getDeviceWidth(context) * 0.25,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                      right: getDeviceWidth(context) * 0.025
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                    Text("Themes", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    const Spacer(),
                    ],
                  ),
                )        ],
            ),
          ),

          // Theme Selection
          Container(
            width: getDeviceWidth(context) * 0.5,
            height: getDeviceHeight(context) * 0.2,
            margin: EdgeInsets.only(
                bottom: getDeviceHeight(context) * 0.025
            ),
            child: Column(
              children: [
                // Light Theme Button
                InkWell(
                  onTap : (){
                    viewModel.changeTheme("light");
                    viewModel.isThemeSelection = false;
                    viewModel.notifyListeners();
                  },
                  child : Container(
                    width: getDeviceWidth(context) * 0.5,
                    height: getDeviceHeight(context) * 0.08,
                    margin: EdgeInsets.only(
                      bottom: getDeviceHeight(context) * 0.025
                    ),
                    child: Row(
                      children: [
                        // Color Icon
                        Container(
                          width: getDeviceWidth(context) * 0.17,
                          margin: EdgeInsets.only(
                            right: getDeviceWidth(context) * 0.03,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(360),
                            boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 10.0, spreadRadius: 3.0)]
                          ),
                        ),

                        // Color Text
                        Container(
                          width: getDeviceWidth(context) * 0.3,
                          child: Text("Light Theme", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black),),
                        )

                      ],
                    ),
                  ),
                ),

                // Dark Theme Button
                InkWell(
                  onTap :(){
                  viewModel.changeTheme("dark");
                  viewModel.isThemeSelection = false;
                  viewModel.notifyListeners();
                  },
                  child : Container(
                  width: getDeviceWidth(context) * 0.5,
                  height: getDeviceHeight(context) * 0.08,
                  child: Row(
                    children: [
                      // Color Icon
                      Container(
                        height: getDeviceHeight(context) * 0.08,
                        width: getDeviceWidth(context) * 0.17,
                        margin: EdgeInsets.only(
                            right: getDeviceWidth(context) * 0.03
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(360),
                            boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 10.0, spreadRadius: 3.0)]
                        ),
                      ),

                      // Color Text
                      Container(
                        width: getDeviceWidth(context) * 0.3,
                        child: Text("Dark Theme", style: TextStyle(color: viewModel.isDarkModeEnabled? Colors.white : Colors.black),),
                      )

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