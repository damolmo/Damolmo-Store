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

    "Return Button" : {
      "settingValue" : "disabled",
      "settingIcon" : Icons.gesture_rounded.codePoint,
    },

    "About Damolmo Store" : {
      "settingValue" : "version",
      "settingIcon" : Icons.info_rounded.codePoint,
    },
  };

  static checkExistingSettings() async {
    // A method that checks if all settings exists!
    List<String> tempSettings  = [];
    List<Settings> settings  = [];

    for (String setting in settingsMap.keys){
      tempSettings.add(setting);
    }

    try{
      settings = await Settings.retrieveExistingSettings();
    } catch (e){
      // Nothing to do
    }

    if (settings.length != tempSettings.length && settings.isNotEmpty)updateExistingSettings(settings, tempSettings);
  }

  static updateExistingSettings(List<Settings> settings, List<String> settingsName) async {
    // This method checks if inserted settings contains every current setting
    List<String> insertedSettingsName = [];

    for (Settings setting in settings) {
      insertedSettingsName.add(setting.settingName);
    }

    for (String currentSettingName in settingsName) {
      if (!insertedSettingsName.contains(currentSettingName)) {
        Settings.insertSettingIntoTable(Settings(settingName: currentSettingName, settingValue: settingsMap[currentSettingName]["settingValue"], settingIcon: settingsMap[currentSettingName]["settingIcon"]));
      }
    }
  }

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