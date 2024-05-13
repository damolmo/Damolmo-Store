import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class AboutAppScreenModel extends HomeScreenModel implements Initialisable{

  @override
  AboutAppScreenModel({
    required this.fontColor,
    required this.backgroundColor,
    required this.isReturnButtonEnabled,
    required this.isAppInit,
    required this.isCategorySelected, required super.uri, required super.context
  }) : super(isAppInit: false);
  
  final bool isCategorySelected;
  final bool isAppInit;
  final bool isReturnButtonEnabled;
  final Color fontColor;
  final Color backgroundColor;
  List<String> aboutTitleString = ["Damolmo's Store version", "Current Device Time", "Current Running OS"];
  List<String> aboutSubtitleString = ["v1.2.6+9", "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}", kIsWeb ? "Web Browser" : "Android" ];
  List<IconData> aboutIcons = [Icons.info, Icons.access_time_rounded, !kIsWeb? Icons.android_rounded : Icons.laptop_rounded ];


  @override
  void initialise(){
  }
}