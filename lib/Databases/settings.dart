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

  factory Settings.fromMap(Map<String,dynamic> map) =>
      Settings(
          settingName: map["settingName"],
          settingValue: map["settingValue"],
          settingIcon: map["settingIcon"]);

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
      db.update("settings", where: "settingName = ?", whereArgs: [setting.settingName], setting.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.update("settings", where: "settingName = ?", whereArgs: [setting.settingName], setting.toMap());
    }
  }

  static rawSettingToInstance(List<Map<String,dynamic>> rawSettings, List<Settings> settings){
    for (Map<String,dynamic> rawSetting in rawSettings){
      settings.add(Settings.fromMap(rawSetting));
    }
    return settings;
  }

  static Future<List<Settings>> retrieveExistingSettings () async {
    // A static method that retrieves current existing settings

    List<Settings> settings = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      settings = rawSettingToInstance(await db.query("settings"), settings);
    } else {
      final Database db = await openDatabase("store.db");
      settings = rawSettingToInstance(await db.query("settings"), settings);
    }

    return settings;
  }

  static Future<List<Settings>> retrieveCustomSettings (String name) async {
    // A static method that retrieves current existing settings

    List<Settings> settings = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      settings = rawSettingToInstance(await db.query("settings", where: "settingName = ?", whereArgs: [name]), settings);
    } else {
      final Database db = await openDatabase("store.db");
      settings = rawSettingToInstance(await db.query("settings", where: "settingName = ?", whereArgs: [name]), settings);
    }

    return settings;
  }



}