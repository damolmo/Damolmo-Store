import 'dart:io';
import 'package:flutter_app_installer/flutter_app_installer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../exports.dart';
import 'dart:convert';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';

class AppScreenModel extends HomeScreenModel implements Initialisable{

  late Applications app;
  List<Screens> appScreens = [];
  List<String> appDetailsValues = [];
  List<String> appDetailsStr = [];
  List<IconData> appDetailsIcons = [];
  List<TrackingUpdates> tracking  = [];
  List<PendingUpdates> pending = [];
  String downloadPath = "";
  bool downloadFileExists = false;
  int waitingCountAfterComplete = 0;
  String downloadProgress = "";
  var dio = Dio();


  @override
  Future<void> initialise() async {
    isDarkModeEnabled = super.isDarkModeEnabled;
    awaitForScreens();
    notifyListeners();
    await FlutterDownloader.initialize(
        debug: true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl: true // option: set to false to disable working with http links (default: false)
    );
  }

  void awaitForScreens() async {
    // A method that await for screens
    CountdownTimer timer = CountdownTimer(const Duration(seconds: 30), const Duration(seconds: 1));
    var listener = timer.listen(null);

    listener.onData((data) {
      if (app.appName.isNotEmpty && appScreens.isEmpty){
        getAppDetails();
        getAppScreens();
      }
    });
  }

  void getAppScreens() async {
    // A method that returns screens for the user submitted app
    try {
      appScreens = await Screens.retrieveExistingScreensPerApp(app.appName);
      notifyListeners();
    } catch (e){
      ScreensData.updateScreensApp();
      appScreens = await Screens.retrieveExistingScreensPerApp(app.appName);
      notifyListeners();
    }
  }

  void getAppDetails() async {
    // Save relevant data to a list
    appDetailsValues = [app.appVersion, app.appMinSDK, app.appCategory, app.appCreationDate, app.appModificationDate];
    appDetailsStr = ["Version", "Android Version", "Category", "Creation Date", "Modification Date"];
    appDetailsIcons = [Icons.text_fields_rounded, Icons.android_rounded, Icons.category_rounded, Icons.date_range_rounded, Icons.update ];
    notifyListeners();
  }

  openUrl() async {
    print("hi");
    return launchUrl(Uri.parse(app.appWebUrl));
  }

  void updateTracking() async {
    // Update tracking version with previous one
    TrackingUpdates.updatePendingUpdate(TrackingUpdates(appName: app.appName, appVersion: app.appVersion, appChangelog: "", appIcon: app.appLogo));
  }

  void addAppToTracking() async {
    // A method that allow us to add current app to tracking list
    try {
      tracking = await TrackingUpdates.retrievePendingUpdates();
      notifyListeners();
      updateTracking();
    } catch (e){
      // Empty tracking
      TrackingUpdates.createTrackingUpdatesTable();
      TrackingUpdates.insertUpdateIntoTable(
          TrackingUpdates(
              appName: app.appName,
              appVersion: app.appVersion,
              appChangelog: "",
              appIcon: app.appLogo));
    }
  }

  void startAppDownload() async {
    // A method that allow us download an app file for both web and android
    if (kIsWeb){
      launchUrl(Uri.parse(app.appApkUrl));
    } else {
      // Download app natively
      File tempFile = File('/storage/emulated/0/Download');
      File removeFile = File("${tempFile.path}/${app.appName.toLowerCase().replaceAll(" ", "_")}.apk");
      downloadPath = removeFile.path;
      notifyListeners();
      if (removeFile.existsSync()) removeFile.deleteSync();
      await Dio().download(app.appApkUrl, removeFile.path ,
        onReceiveProgress: showDownloadProgress);
      fileExists();
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      downloadProgress = "${(received / total * 100).toStringAsFixed(0)}%";
      notifyListeners();
    }
  }

  void fileExists() {
    CountdownTimer timer = CountdownTimer(const Duration(minutes: 5), const Duration(seconds: 1));
    var listener = timer.listen(null);
    listener.onData((data) {
      if (File(downloadPath).existsSync() && downloadPath.isNotEmpty && downloadProgress == "100%"){
        downloadFileExists = true;
        notifyListeners();
        listener.pause();
      }
    });
  }
  
  void installApp(String downloadPath) async {
    // Notify User about download
    final FlutterAppInstaller flutterAppInstaller = FlutterAppInstaller();
    flutterAppInstaller.installApk(
      filePath: downloadPath,
    );
    print("Done!");
  }

}