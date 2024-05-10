import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import 'package:audioplayers/audioplayers.dart';
import '../exports.dart';
import '../Databases/applications.dart';

class HomeScreenModel extends BaseViewModel implements Initialisable{

  bool isDarkModeEnabled = false;
  bool isNewSong = true;
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


  @override
  void initialise(){
    //playSong(); // Play a song
    //playThemeOnLoop(); // Start loop
    getApplications(); // Get Apps
    getCategories(); // Get Categories
    getRandomBanner(); // Get Random Banner
  }

  bool getDarkModeStatus() => isDarkModeEnabled;

  void setDarkModeStatus(bool state){
    isDarkModeEnabled = state;
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppScreenView(app: app, isDarkModeEnabled: isDarkModeEnabled,)));

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
        stopSongServices();
      }
    }
  }

  void stopSongServices() async {
    // A method that collects all functions on one place
    player.pause();
    player.stop();
    notifyListeners();
    //playSong();
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