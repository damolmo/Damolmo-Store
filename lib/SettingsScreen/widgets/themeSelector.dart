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
      width: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.3 : getDeviceWidth(context) * 0.7,
      height: getDeviceHeight(context) * 0.4,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.3,
        bottom: getDeviceHeight(context) * 0.3,
        right: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.35 : getDeviceWidth(context) * 0.15,
        left: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) * 0.35 : getDeviceWidth(context) * 0.15
      ),
      decoration: BoxDecoration(
        color: viewModel.backgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 10.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)]
      ),
      child: Column(
        children: [
          // Themes Windows Banner
          Container(
            width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.25 : getDeviceWidth(context) * 0.5,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.025,
              left: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.025 : getDeviceWidth(context) * 0.05,
              right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.025 : getDeviceWidth(context) * 0.05,
            ),
            child: Row(
              children: [
                // Theme Icon
                Container(
                  width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.10 : getDeviceWidth(context) * 0.2,
                  height: getDeviceHeight(context) * 0.1,
                  child: Icon(Icons.palette, color: viewModel.fontColor, size: getDeviceWidth(context) > 580 ?  44 : 45,),
                ),

                // Theme Text
                Container(
                  width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.15 : getDeviceWidth(context) * 0.25,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                      right: getDeviceWidth(context) > 580 ?  0.0 :getDeviceWidth(context) * 0.05
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                    Text("Themes", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) * 0.03 : getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: getDeviceWidth(context) > 580 ?  TextAlign.left : TextAlign.center,),
                    const Spacer(),
                    ],
                  ),
                )        ],
            ),
          ),

          // Theme Selection
          Container(
            width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.3 : getDeviceWidth(context) * 0.6,
            height: getDeviceHeight(context) * 0.25,
            margin: EdgeInsets.only(
            ),
            child: ListView.builder(
                itemCount: viewModel.themes.length,
                itemBuilder: (context, index){
                  return // Light Theme Button
                    InkWell(
                      onTap : (){
                        viewModel.changeTheme(viewModel.themes[index].themeName);
                        viewModel.isThemeSelection = false;
                        viewModel.notifyListeners();
                        viewModel.restartApp();
                      },
                      child : Container(
                        width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.3 : getDeviceWidth(context) * 0.5,
                        height: getDeviceHeight(context) * 0.1,
                        margin: EdgeInsets.only(
                          top: getDeviceHeight(context) * 0.015,
                          left: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.025 : getDeviceWidth(context) * 0.05,
                            right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.0 : getDeviceWidth(context) * 0.05,
                        ),
                        child: Row(
                          children: [
                            // Color Icon
                            Container(
                              height : getDeviceHeight(context) * 0.06,
                              width: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) * 0.032 : getDeviceWidth(context) * 0.13,
                              margin: EdgeInsets.only(
                                left: getDeviceWidth(context) * 0.02,
                                right: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.02 : getDeviceWidth(context) * 0.03
                              ),
                              decoration: BoxDecoration(
                                  color:  Color(int.parse(viewModel.themes[index].themeBackgroundColor, radix : 16)),
                                  borderRadius: BorderRadius.circular(130),
                                  boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 10.0, spreadRadius: 3.0)]
                              ),
                            ),

                            // Color Text
                            Container(
                              width: getDeviceWidth(context) > 580 ?   getDeviceWidth(context) * 0.2 : getDeviceWidth(context) * 0.3,
                              margin: EdgeInsets.only(
                              ),
                              child: Text(viewModel.themes[index].themeName, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) * 0.03 : getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: getDeviceWidth(context) > 580 ? TextAlign.left : TextAlign.center,),
                            )

                          ],
                        ),
                      ),
                    );
            }
          )
      ),
        ]
      )
    );
  }

}