import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';


class Screens {

  Screens({
    required this.screenUri,
    required this.screenApp
});

  final String screenUri;
  final String screenApp;

  static const screensTable = """
    CREATE TABLE IF NOT EXISTS screens(
      screenUri TEXT PRIMARY KEY,
      screenApp TEXT,
      FOREIGN KEY(screenApp) REFERENCES application(appName)
    );
  """;

  Map<String,dynamic> toMap() => {"screenUri" : screenUri, "screenApp" : screenApp};
  factory Screens.fromMap(Map<String,dynamic> map) => Screens(screenUri: map["screenUri"], screenApp: map["screenApp"]);

  static createScreensTable() async {
    // A static method that creates the screens table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(screensTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(screensTable));
    }
  }

  static insertScreenIntoTable(Screens screen) async {
    // A static method that allow us to insert a screen into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("screens", screen.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("screens", screen.toMap());
    }
  }

  static dropScreenPerApp(String appName) async {
    // A method that drops all screens for an app

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.delete("screens", where: "screenApp = ? ", whereArgs: [appName]);
    } else {
      final Database db = await openDatabase("store.db");
      db.delete("screens", where: "screenApp = ? ", whereArgs: [appName]);
    }

  }

  static retrieveExistingScreensPerApp(String appName) async {
    // A static method that retrieves all existing screens for a given app

    rawScreenToInstance(List<Map<String,dynamic>> rawScreens, List<Screens> screens){
      for (Map<String,dynamic> rawScreen in rawScreens){
        screens.add(Screens.fromMap(rawScreen));
      }

      return screens;
    }

    List<Screens> screens = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      screens = rawScreenToInstance(await db.query("screens", where: "screenApp = ?", whereArgs: [appName]), screens);
    } else {
      final Database db = await openDatabase("store.db");
      screens = rawScreenToInstance(await db.query("screens", where: "screenApp = ?", whereArgs: [appName]), screens);
    }

    return screens;
  }

}