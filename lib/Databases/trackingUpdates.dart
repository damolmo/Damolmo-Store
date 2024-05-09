import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class TrackingUpdates{

  TrackingUpdates({
    required this.appName,
    required this.appVersion,
    required this.appChangelog,
    required this.appIcon,
  });

  final String appName;
  final String appVersion;
  final String appChangelog;
  final String appIcon;

  static const trackingUpdatesTable = """
    CREATE TABLE IF NOT EXISTS trackingUpdates(
      appName TEXT PRIMARY KEY,
      appVersion TEXT,
      appChangelog TEXT,
      appIcon TEXT,
      FOREIGN KEY(appName) REFERENCES applications(appName)
    );
  """;

  Map<String,dynamic> toMap() => {"appName" : appName, "appVersion" : appVersion, "appChangelog" : appChangelog, "appIcon" : appIcon};
  factory TrackingUpdates.fromMap(Map<String,dynamic> map) => TrackingUpdates(appName: map["appName"], appVersion: map["appVersion"], appChangelog: map["appChangelog"], appIcon: map["appIcon"]);

  static createTrackingUpdatesTable() async {
    // A static method that allow us to create the tracking updates table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(trackingUpdatesTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(trackingUpdatesTable));
    }
  }

  static insertUpdateIntoTable(TrackingUpdates tracking) async {
    // A static method that inserts an update for a tracking app
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("pendingUpdates", tracking.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("pendingUpdates", tracking.toMap());
    }
  }

  static updatePendingUpdate(TrackingUpdates tracking) async {
    // A static method that allow to increment the pending update values
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.update("trackingUpdates", tracking.toMap(), where: "appName = ?", whereArgs: [tracking.appName]);
    } else {
      final Database db = await openDatabase("store.db");
      db.update("trackingUpdates", tracking.toMap(), where: "appName = ?", whereArgs: [tracking.appName]);
    }
  }

  static Future<List<TrackingUpdates>> retrievePendingUpdates() async {
    // A static method that returns all existing pending updates

    rawTrackingToInstance(List<Map<String,dynamic>> rawTrackings, List<TrackingUpdates> tracking) {
      for (Map<String,dynamic> rawTracking in rawTrackings){
        tracking.add(TrackingUpdates.fromMap(rawTracking));
      }

      return tracking;
    }


    List<TrackingUpdates> tracking = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      tracking = rawTrackingToInstance(await db.query("trackingUpdates"), tracking);
    } else {
      final Database db = await openDatabase("store.db");
      tracking = rawTrackingToInstance(await db.query("trackingUpdates"), tracking);
    }

    return tracking;
  }

}