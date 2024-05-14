import 'package:damolmo_store/Data/themesData.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';
import 'package:flutter/material.dart';

class SettingsScreenModel extends HomeScreenModel implements Initialisable{

  @override
  SettingsScreenModel({
    required this.fontColor,
    required this.backgroundColor,
    required this.apps,
    required this.ogApps,
    required this.categories,
    required this.selectedEntry,
    required this.isReturnButtonEnabled, required super.isAppInit, required super.uri, required super.context
});

  int selectedEntry;
  final Color fontColor;
  final Color backgroundColor;
  List<Settings> settings = [];
  List<Applications> apps;
  List<Categories> categories;
  List<Applications> ogApps;
  final bool isReturnButtonEnabled;
  List<TrackingUpdates> tracking = [];
  bool isThemeSelection = false;
  bool isTrackingListView = false;
  bool isReturnButtonWindows = false;
  List<Themes> themes = [];

  @override
  void initialise(){
    checkForNewSettings();
    getCurrentSettings();
    getCurrentTracking();
    getCurrentThemes();
    print(ogApps);
    print(apps);
  }

  void setDisplayButton(String value) async {
    // Set on/off on display button
    try {
      Settings.updateExistingSetting(Settings(settingName: "Return Button", settingValue: value, settingIcon: Icons.gesture.codePoint));
    } catch (e){
      // Nothing to do
    }
  }

  void checkForNewSettings() async {
    // A method that checks new data
    SettingsData.checkExistingSettings();
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
      //Restart.restartApp();
    });
  }

  void removeSelectedAppFromTracking(TrackingUpdates tracking) async {
    // A method that removes a selected app from tracking
    TrackingUpdates.removeTrackingUpdate(tracking);
    getCurrentTracking(); // Refresh display data

  }


}