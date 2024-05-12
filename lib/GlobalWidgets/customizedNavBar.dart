import 'package:flutter/material.dart';
import '../exports.dart';

class CustomizedNavBar extends StatelessWidget{
  @override
  const CustomizedNavBar({
    required this.viewModel,
    super.key
});

  final dynamic viewModel;

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
        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.1), blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
        borderRadius: BorderRadius.circular(25),
        color: viewModel.backgroundColor
      ),
      child : Row(
        children: [
          const Spacer(),

          // Home Button
          InkWell(
            onTap: (){
              viewModel.stopSongServices();
              viewModel.selectedEntry = 0;
              viewModel.notifyListeners();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreenView(isAppInit: false,)));

            },
            child : Container(
              width : getDeviceWidth(context) * 0.25,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                right: getDeviceWidth(context) * 0.05
              ),
              child: Column(
                children: [
                  Spacer(),
                  // Route Icon
                  Icon(Icons.category_rounded, color: Colors.orange, size: viewModel.getMenuEntry() == 0 ? 45 : 35,),

                  // Route Name
                  Row(
                    children: [
                      const Spacer(),
                      Text("Categories", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                      const Spacer(),
                    ],
                  ),
                  Spacer(),

                ],
              )
            ),
          ),


          // Downloads Button
          // Home Button
          InkWell(
            onTap: (){
              viewModel.stopSongServices();
              viewModel.selectedEntry = 1;
              viewModel.notifyListeners();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DownloadsScreenView(fontColor: viewModel.fontColor, backgroundColor: viewModel.backgroundColor, apps: viewModel.apps, selectedEntry: viewModel.selectedEntry, isReturnButtonEnabled: viewModel.isReturnButtonEnabled, ogApps: viewModel.ogApps, categories: viewModel.categories,)));
            },
            child : Container(
                width : getDeviceWidth(context) * 0.25,
                height: getDeviceHeight(context) * 0.1,
                margin: EdgeInsets.only(
                    right: getDeviceWidth(context) * 0.05
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    // Route Icon
                    Icon(Icons.download_rounded, color: Colors.lightBlueAccent, size: viewModel.getMenuEntry() == 1 ? 45 : 35,),

                    // Route Name
                    Row(
                      children: [
                        const Spacer(),
                        Text("Updates", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                  ],
                )
            ),
          ),

          // Settings Button
          // Home Button
          InkWell(
            onTap: (){
              viewModel.stopSongServices();
              viewModel.selectedEntry = 2;
              viewModel.notifyListeners();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreenView(fontColor: viewModel.fontColor, backgroundColor: viewModel.backgroundColor, apps: viewModel.apps, selectedEntry: viewModel.selectedEntry, isReturnButtonEnabled : viewModel.isReturnButtonEnabled, ogApps: viewModel.ogApps, categories: viewModel.categories,)));
            },
            child : Container(
                width : getDeviceWidth(context) * 0.25,
                height: getDeviceHeight(context) * 0.1,
                child: Column(
                  children: [
                    const Spacer(),

                    // Route Icon
                    Icon(Icons.settings_rounded, color: Colors.lightGreen, size: viewModel.getMenuEntry() == 2 ? 45 : 35,),

                    // Route Name
                    Row(
                      children: [
                        const Spacer(),
                        Text("Settings", style: TextStyle(color: Colors.white, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 24.0, offset: Offset.zero)]), textAlign: TextAlign.center,),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                  ],
                )
            ),
          ),
          const Spacer(),
        ],
      )
    );
  }

}