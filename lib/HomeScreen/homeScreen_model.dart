import 'dart:math';
import 'package:damolmo_store/Data/themesData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import 'package:audioplayers/audioplayers.dart';
import '../exports.dart';
import '../Databases/applications.dart';

class HomeScreenModel extends BaseViewModel implements Initialisable{

  @override
  HomeScreenModel({
    required this.isAppInit,
});

  Color fontColor = Colors.black;
  Color backgroundColor = Colors.white;
  bool isNewSong = true;
  bool isHomeScreen = false;
  AudioPlayer player = AudioPlayer();
  String songDuration = "";
  String songPosition = "";
  List<Applications> ogApps = [];
  List<Applications> apps = [];
  List<Categories> categories = [];
  int currentBannerIndex = 0;
  TextEditingController searchField = TextEditingController(text: "");
  bool isCategorySelected = false;
  bool isExitAllowed = false;
  bool showExitPopUp = false;
  bool isCustomSearch = false;
  int choosedCategory = 0;
  int exitCount = 0;
  int selectedEntry = 0;
  bool isReturnButtonEnabled = false;
  bool isAppInit;

  // Data to avoid app crash
  bool isThemeSelection = false;
  bool isTrackingListView = false;
  bool isReturnButtonWindows = false;


  @override
  void initialise(){
    if (isAppInit){
      playSong(); // Play a song
      playThemeOnLoop(); // Start loop
    } else {
      stopSongServices();
    }

    isHomeScreen = true;
    notifyListeners();

    getApplications(); // Get Apps
    getCategories(); // Get Categories
    getRandomBanner(); // Get Random Banner
    getCurrentSettings(); // Checks old data
    addStoreToTracking(); // Auto updates for store
    getReturnButtonState(); // Get gestures config
  }

  List<Applications> getApps() => apps;

  getReturnButtonState() async {
    // A method that allow us to retrieve current gestures config
    List<Settings> currentSetting = [];

    try {
      currentSetting = await Settings.retrieveCustomSettings("Return Button");
    } catch (e){
      // nothing to do
    }

    if (currentSetting.isNotEmpty && currentSetting[0].settingValue == "enabled") isReturnButtonEnabled = true;
    notifyListeners();
  }

  addStoreToTracking() async {
    // A method that allow us to set the store as default tracking app
    List<Applications> storeApp  = [];

    storeApp = await Applications.retrieveApplicationByName("Damolmo Store");

    try {
      TrackingUpdates.createTrackingUpdatesTable();
      TrackingUpdates.insertUpdateIntoTable(
        TrackingUpdates(appName: storeApp[0].appName, appVersion: storeApp[0].appVersion, appChangelog: "", appIcon: storeApp[0].appLogo));
    } catch (e){
      // Nothing to do
    }

  }

  int getMenuEntry() => selectedEntry;

  void getCurrentSettings() async {
    // Check if old data still exists
    List<Settings> temp = [];

    try {
      temp = await Settings.retrieveCustomSettings("Dark Mode");
      Settings.deleteExistingSetting(temp[0]);
    } catch (e){
      // Nothing to do, everything is fine
      getCurrentTheme(); // Gets current background theme
    }


  }


  void getCurrentTheme() async {
    // Get current theme and sets
    // Background Color
    // Font Color

    List<Settings> settingsTemp = [];

    try {
      settingsTemp = await Settings.retrieveCustomSettings("Themes");
      getCurrentThemeData(settingsTemp[0]);
    } catch (e){
     // Nothing to do
    }


  }

  void getCurrentThemeData(Settings setting) async {
    // A method that returns all required values for a given theme name

    List<Themes> themes = [];

    try {
      themes = await Themes.retrieveExistingTheme(setting.settingValue);
      assignThemeData(themes[0]);
    } catch (e){
      ThemesData.insertNewThemes();
      themes = await Themes.retrieveExistingTheme(setting.settingValue);
      assignThemeData(themes[0]);
    }

  }

  void assignThemeData(Themes theme) async {
    // Assigns colors to match current theme selection
    fontColor = Color(int.parse(theme.themeFontColor, radix: 16));
    backgroundColor = Color(int.parse(theme.themeBackgroundColor, radix: 16));
    notifyListeners();
  }


  void searchAppNavigate() async {
    // Search user requested app and return a list with the result
    apps = [];

    for (Applications app in ogApps){
        if (app.appName.toLowerCase().contains(searchField.text.toLowerCase()) && !apps.contains(app)){
          apps.add(app);
      }
    }

    isCategorySelected = true;
    isCustomSearch = true;
    notifyListeners();
  }

  void getCategories() async {
    // A method that fetch current categories

    try {
      categories= await Categories.retrieveExistingCategories();
      notifyListeners();
    } catch (e){
      CategoriesData.insertNewCategory();
      categories= await Categories.retrieveExistingCategories();
      notifyListeners();
    }
  }

  void playSong() {
    // A method that does what is supposed to do
    player.play(AssetSource("sounds/theme.mp3"));
  }

  void getAppsByCategory(String categoryName) async {
    // A method that returns a list of apps by category
    apps = await Applications.retrieveApplicationByCategory(categoryName);
    notifyListeners();
  }

  void getApplications() async {
    try {
      ogApps = await Applications.retrieveAllExistingApplications();
      notifyListeners();
    } catch (e){
      AppsData.getLatestData();
      ogApps = await Applications.retrieveAllExistingApplications();
      notifyListeners();
    }
    notifyListeners();
  }


  void getRandomBanner() async {
    // A method that allow us to get a brand new banner after some time
    CountdownTimer timer = CountdownTimer(const Duration(hours: 24), const Duration(seconds: 1));
    var listener = timer.listen(null);
    int count = 0;

    listener.onData((data) {
      if (count < 5){
        count +=1;
      } else {
        // Time to swap the banner
        if (ogApps.isNotEmpty){
          currentBannerIndex = Random().nextInt(ogApps.length);
          count = 0;
          notifyListeners();
        } else {
          getApplications();
        }

      }
    });
  }

  navigateToRoute(BuildContext context, String route){
    stopSongServices(); // Needed to avoid unexpected behaviours
    return Navigator.of(context).pushReplacementNamed(route);
  }

  navigateToAppPage(BuildContext context, Applications app) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppScreenView(app: app, fontColor: fontColor, backgroundColor: backgroundColor, apps: apps, isReturnButtonEnabled : isReturnButtonEnabled, ogApps: ogApps, categories: categories,)));

  void compareSongDurations(Duration d, String durationType) async {
    // a method that allow us to compare durations and manage the sound process

    if (durationType == "full"){
      // We've the full song duration
        songDuration = "${d.inHours}:${d.inMinutes}:${d.inSeconds}";
        notifyListeners();

    } else {
      // We've the current song duration
      songPosition = "${d.inHours}:${d.inMinutes}:${d.inSeconds}";
      notifyListeners();

      if (songPosition == songDuration){
        rebootSong();
      }
    }
  }

  void rebootSong() async {
    // Play song service again when finished
    player.stop();
    player.release();
    playSong(); // Play a song
  }

  void stopSongServices() async {
    // A method that collects all functions on one place
    player.pause();
    player.resume();
  }

  void playThemeOnLoop() async{
    // A method that allow us to play a song forever :)

    player.onDurationChanged.listen((Duration d) {
      compareSongDurations(d, "full");
    });

    player.onPositionChanged.listen((Duration d) {
        compareSongDurations(d, "current");
      });

  }
}