import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../exports.dart';

class StoreAppBar extends StatelessWidget{
  @override
  const StoreAppBar({
    required this.viewModel,
    super.key
});

  final viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width : getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.1,
      margin : EdgeInsets.only(
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05,
        bottom: getDeviceHeight(context) * 0.875,
        top: getDeviceHeight(context) * 0.025
      ),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      child : Row(
        children: [
          // App Icon
          InkWell(
            onTap :  (){
             // TO-DO
            },
            child : Container(
            width: getDeviceWidth(context) * 0.1,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              right: getDeviceWidth(context) * 0.05,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/logo/logo.png")
              )
            ),
            ),
          ),

          // Search Bar
          Container(
            width: getDeviceWidth(context) * 0.6,
            height: getDeviceHeight(context) * 0.7,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.015,
              bottom: getDeviceHeight(context) * 0.015,
              right: getDeviceWidth(context) * 0.025
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: viewModel.isDarkModeEnabled ?  Colors.black.withOpacity(0.6) : Colors.white,
              boxShadow: [BoxShadow(color: viewModel.isDarkModeEnabled ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4), blurStyle: BlurStyle.normal, blurRadius: 4.0, spreadRadius: 3.0)]
            ),
            child: TextField(
              onTap: (){
                // TO-DO
              },

              onEditingComplete: (){
                if (viewModel.searchField.text.isNotEmpty) {
                  viewModel.searchAppNavigate();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                } else {
                  viewModel.isCategorySelected = false;
                  viewModel.notifyListeners();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
              style: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Tap to search",
                hintStyle: TextStyle(color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06,)
              ),
              controller: viewModel.searchField,
              keyboardType: TextInputType.name,
              maxLines: 1,
            ),
          ),

          //Search Icon
          Container(
            width: getDeviceWidth(context) * 0.1,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.025,
            ),
            child: InkWell(
              onTap : (){
                if (viewModel.searchField.text.isNotEmpty) {
                  viewModel.searchAppNavigate();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                } else {
                  viewModel.isCategorySelected = false;
                  viewModel.notifyListeners();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              },
              child : Icon(Icons.search_rounded, color: viewModel.isDarkModeEnabled ? Colors.white : Colors.black, size: 40, shadows: [Shadow(color: viewModel.isDarkModeEnabled ?  Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5), blurRadius: 2.0, offset: Offset.zero)],)),
          ),
        ],
      ),
    );

  }
}