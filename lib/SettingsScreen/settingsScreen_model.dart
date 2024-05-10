import 'package:stacked/stacked.dart';
import '../exports.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class SettingsScreenModel extends HomeScreenModel implements Initialisable{

  @override
  SettingsScreenModel({
    required this.isDarkModeEnabled,
    required this.apps,
}) : super(isDarkModeEnabled: false);

  bool isDarkModeEnabled;
  List<Settings> settings = [];
  final List<Applications> apps;
  List<TrackingUpdates> tracking = [];
  bool isThemeSelection = false;
  bool isTrackingListView = false;

  @override
  void initialise(){
    getCurrentSettings();
    getCurrentTracking();
  }

  void getCurrentTracking() async {
    // A method that retrieves current apps in tracking
    try {
      tracking = await TrackingUpdates.retrievePendingUpdates();
      notifyListeners();
    } catch (e){
      // Nothing to do
    }
  }

  void getCurrentSettings() async {
    // A method that returns a full list of settings
    try{
      settings = await Settings.retrieveExistingSettings();
      notifyListeners();
    } catch (e){
      SettingsData.insertSettingsIntoMap();
      settings = await Settings.retrieveExistingSettings();
      notifyListeners();
    }
  }

  void changeTheme(String value) async {
    // Update current theme
    Settings.updateExistingSetting(
        Settings(settingName: "Dark Mode", settingValue: value, settingIcon: Icons.palette.codePoint));
    Restart.restartApp();
  }

  void removeSelectedAppFromTracking(TrackingUpdates tracking) async {
    // A method that removes a selected app from tracking
    TrackingUpdates.removeTrackingUpdate(tracking);
    getCurrentTracking(); // Refresh display data

  }


}