import '../exports.dart';
import 'package:flutter/material.dart';

class SettingsData{

  static Map<String,dynamic> settingsMap = {
    "Themes" : {
      "settingValue" : "light",
      "settingIcon" : Icons.palette.codePoint,
    },

    "Tracking Apps" : {
      "settingValue" : "tracking",
      "settingIcon" : Icons.apps.codePoint,
    },

    "App Source Code" : {
      "settingValue" : "about",
      "settingIcon" : Icons.code_rounded.codePoint,
    },
  };

  static insertSettingsIntoMap() async {
    // A method that inserts the settings into the settings table
    Settings.createSettingsTable();

    for (String settingName in settingsMap.keys){
      Settings.insertSettingIntoTable(
        Settings(
            settingName: settingName,
            settingValue: settingsMap[settingName]["settingValue"],
            settingIcon: settingsMap[settingName]["settingIcon"],)
      );
    }
  }

}