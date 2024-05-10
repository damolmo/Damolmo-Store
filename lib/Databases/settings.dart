import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class Settings {

  Settings({
    required this.settingName,
    required this.settingValue,
    required this.settingIcon
});

  final String settingName;
  final String settingValue;
  final int settingIcon;

  static const settingsTable = """
    CREATE TABLE IF NOT EXISTS settings(
      settingName TEXT PRIMARY KEY,
      settingValue TEXT,
      settingIcon INTEGER
    );
  """;

  Map<String,dynamic> toMap() => {"settingName" : settingName, "settingValue" : settingValue, "settingIcon" : settingIcon};


  static createSettingsTable() async {
    // A static method that allow us to create the settings table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(settingsTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(settingsTable));
    }
  }

  static insertSettingIntoTable(Settings setting) async {
    // A static method that allow us to insert a new setting into the settings table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("settings", setting.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("settings", setting.toMap());
    }
  }

  static updateExistingSetting(Settings setting) async {
    // A static method that retrieves an existing setting
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.update("settings", setting.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.update("settings", setting.toMap());
    }
  }



}