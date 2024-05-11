import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Themes {

  Themes({
    required this.themeName,
    required this.themeBackgroundColor,
    required this.themeFontColor
});

  final String themeName;
  final String themeBackgroundColor;
  final String themeFontColor;

  static const themesTable = """
    CREATE TABLE IF NOT EXISTS themes(
      themeName TEXT PRIMARY KEY,
      themeBackgroundColor TEXT,
      themeFontColor TEXT
    );
  """;

  Map<String,dynamic> toMap() => {"themeName" : themeName, "themeBackgroundColor" : themeBackgroundColor, "themeFontColor" : themeFontColor};

  factory Themes.fromMap(Map<String,dynamic> map) =>
      Themes(
          themeName: map["themeName"],
          themeBackgroundColor: map["themeBackgroundColor"],
          themeFontColor: map["themeFontColor"]);


  static createThemesData() async {
    // A static method to create the themes table

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(themesTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(themesTable));
    }
  }

  static insertThemeIntoTable(Themes theme) async {
    // A static method to insert a new theme into the themes table

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("themes", theme.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("themes", theme.toMap());
    }
  }

  static rawThemeToInstances(List<Map<String,dynamic>> rawThemes, List<Themes> themes){
    for (Map<String,dynamic> rawTheme in rawThemes){
      themes.add(Themes.fromMap(rawTheme));
    }
    return themes;
  }

  static Future<List<Themes>> retrieveExistingTheme(String themeName) async {
    // A static method that returns a full list of themes

    List<Themes> themes = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      themes = rawThemeToInstances(await db.query("themes", where: "themeName = ?", whereArgs:[themeName] ), themes);
    } else {
      final Database db = await openDatabase("store.db");
      themes = rawThemeToInstances(await db.query("themes", where: "themeName = ?", whereArgs:[themeName] ), themes);
    }

    return themes;
  }

  static Future<List<Themes>> retrieveAllExistingTheme() async {
    // A static method that returns a full list of themes

    List<Themes> themes = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      themes = rawThemeToInstances(await db.query("themes"), themes);
    } else {
      final Database db = await openDatabase("store.db");
      themes = rawThemeToInstances(await db.query("themes"), themes);
    }

    return themes;
  }



}