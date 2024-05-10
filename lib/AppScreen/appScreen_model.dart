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

  @override
  AppScreenModel({
    required this.app
});

  final Applications app;
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
  void initialise() async  {
    getAppScreens();
    getAppDetails();
  }

  void getAppScreens() async {
    // A method that returns screens for the user submitted app
    try {
      appScreens = await Screens.retrieveExistingScreensPerApp(app.appName);
      notifyListeners();
    } catch (e){
      ScreensData.insertNewScreens();
      appScreens = await Screens.retrieveExistingScreensPerApp(app.appName);
      notifyListeners();
    }
    print("[1/2] Completed");
  }

  void getAppDetails() async {
    // Save relevant data to a list
    appDetailsValues = [app.appVersion, app.appMinSDK, app.appCategory, app.appCreationDate, app.appModificationDate];
    appDetailsStr = ["Version", "Android Version", "Category", "Creation Date", "Modification Date"];
    appDetailsIcons = [Icons.text_fields_rounded, Icons.android_rounded, Icons.category_rounded, Icons.date_range_rounded, Icons.update ];
    print("[2 /2] Completed");
    notifyListeners();
  }

  openUrl() async {
    print("hi");
    return launchUrl(Uri.parse(app.appWebUrl));
  }

  void updateTracking() async {
    // Update tracking version with previous one

    TrackingUpdates.updatePendingUpdate(TrackingUpdates(appName: app.appName, appVersion: app.appVersion, appChangelog: "", appIcon: app.appLogo));
    TrackingUpdates.insertUpdateIntoTable(TrackingUpdates(appName: app.appName, appVersion: app.appVersion, appChangelog: "", appIcon: app.appLogo));

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

    List<TrackingUpdates> track = await TrackingUpdates.retrievePendingUpdates();
    print(track.length);
  }

  void startAppDownload() async {
    // A method that allow us download an app file for both web and android

    if (kIsWeb){
      launchUrl(Uri.parse(app.appApkUrl));
    } else {
      // Download app natively
      File tempFile = File("/storage/emulated/0/Download/${app.appName.toLowerCase().replaceAll(" ", "_")}_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().second}_${DateTime.now().minute}_${DateTime.now().hour}.apk");
      downloadPath = tempFile.path;
      notifyListeners();
      downloadFile();
    }
  }

  void downloadFile() async {
    await Dio().download(app.appApkUrl, downloadPath ,
        onReceiveProgress: showDownloadProgress);
    fileExists();
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