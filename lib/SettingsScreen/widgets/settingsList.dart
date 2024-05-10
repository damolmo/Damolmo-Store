import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../exports.dart';

class SettingsList extends StatelessWidget{
  @override
  const SettingsList({
    required this.viewModel,
    super.key
});

  final SettingsScreenModel viewModel;

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
      child: ListView.builder(
          itemCount: viewModel.settings.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap : (){
                if (viewModel.settings[index].settingName == "Dark Mode"){
                  viewModel.isThemeSelection = true;
                  viewModel.notifyListeners();
                } else if (viewModel.settings[index].settingName == "Tracking Apps"){
                  viewModel.isTrackingListView = true;
                  viewModel.notifyListeners();
                } else {
                  launchUrl(Uri.parse("https://github.com/damolmo/Damolmo-Store"));
                }
              },
                child : Container(
                  width: getDeviceWidth(context) * 0.9,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                    top: getDeviceHeight(context) * 0.03,
                    left: getDeviceWidth(context) * 0.025,
                    right: getDeviceWidth(context) * 0.025
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.6) : Colors.black.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 10.0, spreadRadius: 2.0)],
                    borderRadius: BorderRadius.circular(12),
                    color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.8) : Colors.white
                  ),
                  child: ListTile(
                    leading: Icon(IconData(viewModel.settings[index].settingIcon, fontFamily: 'MaterialIcons'), color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black,),
                    title: Text(viewModel.settings[index].settingName, style: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05),),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios, color: viewModel.isDarkModeEnabled?  Colors.white : Colors.black.withOpacity(0.6), size : 40), ),
                  ),
                ),
            );
         },
      ),
    );
  }
}