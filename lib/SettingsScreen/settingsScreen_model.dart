import 'package:damolmo_store/Data/themesData.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class SettingsScreenModel extends HomeScreenModel implements Initialisable{

  @override
  SettingsScreenModel({
    required this.fontColor,
    required this.backgroundColor,
    required this.apps,
});

  final Color fontColor;
  final Color backgroundColor;
  List<Settings> settings = [];
  final List<Applications> apps;
  List<TrackingUpdates> tracking = [];
  bool isThemeSelection = false;
  bool isTrackingListView = false;
  List<Themes> themes = [];

  @override
  void initialise(){
    getCurrentSettings();
    getCurrentTracking();
    getCurrentThemes();
  }

  void getCurrentThemes() async {
    // A method that retrieves current themes on database
    try {
      themes = await Themes.retrieveAllExistingTheme();
      notifyListeners();
    } catch (e){
      ThemesData.insertNewThemes();
      themes = await Themes.retrieveAllExistingTheme();
      notifyListeners();
    }
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
          Settings(settingName: "Themes",
              settingValue: value,
              settingIcon: Icons.palette.codePoint));
  }

  restartApp(){
    CountdownTimer timer = CountdownTimer(const Duration(seconds: 1), const Duration(seconds: 1));
    // Await some time
    var listener = timer.listen(null);
    listener.onData((data) {
      // Restart app
      Restart.restartApp();
    });
  }

  void removeSelectedAppFromTracking(TrackingUpdates tracking) async {
    // A method that removes a selected app from tracking
    TrackingUpdates.removeTrackingUpdate(tracking);
    getCurrentTracking(); // Refresh display data

  }


}