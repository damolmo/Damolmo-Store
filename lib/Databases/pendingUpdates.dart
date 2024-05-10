import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class PendingUpdates{

  PendingUpdates({
    required this.appName,
    required this.appVersion,
    required this.appChangelog,
    required this.appIcon,
});

  final String appName;
  final String appVersion;
  final String appChangelog;
  final String appIcon;

  static const pendingUpdatesTable = """
    CREATE TABLE IF NOT EXISTS pendingUpdates(
      appName TEXT PRIMARY KEY,
      appVersion TEXT,
      appChangelog TEXT,
      appIcon TEXT,
      FOREIGN KEY(appName) REFERENCES applications(appName)
    );
  """;

  Map<String,dynamic> toMap() => {"appName" : appName, "appVersion" : appVersion, "appChangelog" : appChangelog, "appIcon" : appIcon};
  factory PendingUpdates.fromMap(Map<String,dynamic> map) => PendingUpdates(appName: map["appName"], appVersion: map["appVersion"], appChangelog: map["appChangelog"], appIcon: map["appIcon"]);

  static createPendingUpdatesTable() async {
    // A static method that allow us to create the pending updates table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(pendingUpdatesTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(pendingUpdatesTable));
    }
  }

  static insertUpdateIntoTable(PendingUpdates pending) async {
    // A static method that inserts an update for a tracking app
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("pendingUpdates", pending.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("pendingUpdates", pending.toMap());
    }
  }

  static updatePendingUpdate(PendingUpdates pending) async {
    // A static method that allow to increment the pending update values
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.update("pendingUpdates", pending.toMap(), where: "appName = ?", whereArgs: [pending.appName]);
    } else {
      final Database db = await openDatabase("store.db");
      db.update("pendingUpdates", pending.toMap(), where: "appName = ?", whereArgs: [pending.appName]);
    }
  }

  static deletePendingUpdate(PendingUpdates pending) async {
    // A static method that drops a pending update if exists
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.delete("pendingUpdates", where: "appName = ?", whereArgs: [pending.appName]);
    } else {
      final Database db = await openDatabase("store.db");
      db.delete("pendingUpdates", where: "appName = ?", whereArgs: [pending.appName]);
    }
  }

  static Future<List<PendingUpdates>> retrievePendingUpdates() async {
    // A static method that returns all existing pending updates

    rawPendingToInstance(List<Map<String,dynamic>> rawPendings, List<PendingUpdates> pending) {
      for (Map<String,dynamic> rawPending in rawPendings){
        pending.add(PendingUpdates.fromMap(rawPending));
      }

      return pending;
    }


    List<PendingUpdates> pending = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      pending = rawPendingToInstance(await db.query("pendingUpdates"), pending);
    } else {
      final Database db = await openDatabase("store.db");
      pending = rawPendingToInstance(await db.query("pendingUpdates"), pending);
    }

    return pending;
  }

}