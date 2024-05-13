import 'dart:io';

import 'package:flutter_app_installer/flutter_app_installer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class DownloadsScreenModel extends HomeScreenModel implements Initialisable{

  @override
  DownloadsScreenModel({
    required this.fontColor,
    required this.backgroundColor,
    required this.selectedEntry,
    required this.isReturnButtonEnabled,
    required this.apps,
    required this.ogApps,
    required this.categories, required super.isAppInit,
});

  @override
  final bool isReturnButtonEnabled;
  int selectedEntry;
  final Color fontColor;
  final Color backgroundColor;
  List<PendingUpdates> pending = [];
  List<TrackingUpdates> tracking = [];
  List<Categories> categories;
  List<Applications> apps;
  List<Applications> ogApps;
  List<DownloadsHistory> downloads = [];
  int choosedAppIndex = 0;
  bool isDownloadDetails = false;
  bool isDownloadsScreen = false;
  int choosedDownloadIndex = 0;

  // Data to avoid app crash
  bool isThemeSelection = false;
  bool isTrackingListView = false;
  bool isReturnButtonWindows = false;

  @override
  void initialise(){
    checkForUpdates(); // Get Latest Apps
    getTrackingData();
    notifyListeners();
    getCurrentDownloads();
  }

  installUserFile(DownloadsHistory download) async {
    // A method that installs a file
    final FlutterAppInstaller flutterAppInstaller = FlutterAppInstaller();
    flutterAppInstaller.installApk(
      filePath: download.downloadPath,
    );
  }


  deleteUserFile(DownloadsHistory download) async {
    // A method that deletes an existing file

    File tempFile =  File(download.downloadPath);

    if (tempFile.existsSync()){
      // File exists proceed to delete it
      tempFile.deleteSync();
      DownloadsHistory.deleteSingleDownload(download);
      downloads.remove(download);
      notifyListeners();
    }
  }

  getCurrentDownloads() async {
    // Return latest downloads

    try {
      downloads = await DownloadsHistory.retrieveCurrentDownloads();
      notifyListeners();
    } catch (e){
      // Nothing to do, empty list :)
    }

    print(downloads);
  }

  getApp(String appName, BuildContext context) async {
    // A method to allow users to get selected app data
    for (Applications app in apps){
      if (app.appName == appName){
        choosedAppIndex = apps.indexOf(app);
        notifyListeners();
      }
    }

    return super.navigateToAppPage(context, apps[choosedAppIndex]);
  }

  void getTrackingData() async {
    // A method that allow us to track latest data with server data
    try {
      tracking = await TrackingUpdates.retrievePendingUpdates();
      notifyListeners();
    } catch (e){
      // Surprise, pending is empty
    }

    if (tracking.isNotEmpty) refreshTrackingList();

  }

  void refreshTrackingList() async {
    // Compares both, tracking and updates lists

    print(tracking[0].appVersion);
    print(tracking.length);

    for(Applications app in apps){
      for (TrackingUpdates track in tracking){
        if (app.appName == track.appName && app.appVersion != track.appVersion){
          // We've a new update here
          pending.add(PendingUpdates(appName: app.appName, appVersion: app.appVersion, appChangelog: "", appIcon: app.appLogo));
          notifyListeners();
          try {
            PendingUpdates.createPendingUpdatesTable();
            PendingUpdates.insertUpdateIntoTable(
                PendingUpdates(
                    appName: app.appName,
                    appVersion: app.appVersion,
                    appChangelog: "",
                    appIcon: app.appLogo));
          } catch (e){
            PendingUpdates.updatePendingUpdate(
                PendingUpdates(
                    appName: app.appName,
                    appVersion: app.appVersion,
                    appChangelog: "",
                    appIcon: app.appLogo));
          }
        } else if (app.appName == track.appName && app.appVersion == track.appVersion){
          // This app is already updated
          // Remove from pending if exists
          try {
            PendingUpdates.deletePendingUpdate(PendingUpdates(
                appName: app.appName,
                appVersion: app.appVersion,
                appChangelog: "",
                appIcon: app.appLogo));
          } catch (e){
            // Seems like it no longer exists
          }
        }
      }
    }
  }

  void checkForUpdates() async {
    // This method will check for updates for tracking apps

    print("Checking for updates");

    try {
      AppsData.getLatestData();
      apps = await Applications.retrieveAllExistingApplications();
      notifyListeners();
    } catch (e){
      // Server Slow?
    }
  }
}