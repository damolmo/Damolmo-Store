import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Applications {

  Applications({
    required this.appName,
    required this.appLogo,
    required this.appVersion,
    required this.appBanner,
    required this.appAuthor,
    required this.appCreationDate,
    required this.appModificationDate,
    required this.appDescription,
    required this.appMinSDK,
    required this.hasWebSupport,
    required this.appCategory,
    required this.appWebUrl,
    required this.appApkUrl,
    required this.webShareUri,
    required this.androidShareUri,
});

  final String appName;
  final String appLogo;
  final String appVersion;
  final String appBanner;
  final String appAuthor;
  final String appCreationDate;
  final String appModificationDate;
  final String appDescription;
  final String appMinSDK;
  final String hasWebSupport;
  final String appCategory;
  final String appWebUrl;
  final String appApkUrl;
  final String webShareUri;
  final String androidShareUri;

  static const applicationsTable = """
    CREATE TABLE IF NOT EXISTS applications(
      appName TEXT PRIMARY KEY,
      appLogo TEXT,
      appVersion TEXT,
      appBanner TEXT,
      appAuthor TEXT,
      appCreationDate TEXT,
      appModificationDate TEXT,
      appDescription TEXT,
      appMinSDK TEXT,
      hasWebSupport TEXT,
      appCategory TEXT,
      appWebUrl TEXT,
      appApkUrl TEXT,
      webShareUri TEXT,
      androidShareUri TEXT,
      FOREIGN KEY(appCategory) REFERENCES categories(categoryName)
    );
  """;

  Map<String,dynamic> toMap() => {
    "appName" : appName,
    "appLogo" : appLogo,
    "appVersion" : appVersion,
    "appBanner" : appBanner,
    "appAuthor" : appAuthor,
    "appCreationDate" : appCreationDate,
    "appModificationDate" : appModificationDate,
    "appDescription" : appDescription,
    "appMinSDK" : appMinSDK,
    "hasWebSupport" : hasWebSupport,
    "appCategory" : appCategory,
    "appWebUrl" : appWebUrl,
    "appApkUrl" : appApkUrl,
    "webShareUri" : webShareUri,
    "androidShareUri" : androidShareUri
  };

  factory Applications.fromMap(Map<String,dynamic> map) =>
    Applications(
        appName: map["appName"],
        appLogo: map["appLogo"],
        appVersion: map["appVersion"],
        appBanner: map["appBanner"],
        appAuthor: map["appAuthor"],
        appCreationDate: map["appCreationDate"],
        appModificationDate: map["appModificationDate"],
        appDescription: map["appDescription"],
        appMinSDK: map["appMinSDK"],
        hasWebSupport: map["appMinSDK"],
        appCategory: map["appCategory"],
        appWebUrl: map["appWebUrl"],
        appApkUrl: map["appApkUrl"],
        androidShareUri: map["androidShareUri"],
        webShareUri: map["webShareUri"]
    );

  static createApplicationsTable() async {
    // A static method that allow us to create the applications table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(applicationsTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(applicationsTable));
    }
  }

  static insertAppIntoTable(Applications application) async {
    // A static method that allow us to insert a new app
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("applications", application.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("applications", application.toMap());
    }
  }

  static updateExistingApplication(Applications application) async {
    // A static method that allow us to update an existing app

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.update("applications", application.toMap(), where: "appName = ?", whereArgs: [application.appName]);
    } else {
      final Database db = await openDatabase("store.db");
      db.update("applications", application.toMap(), where: "appName = ?", whereArgs: [application.appName]);
    }
  }

  static rawAppToInstances(List<Map<String,dynamic>> rawApps, List<Applications> apps){
    for (Map<String,dynamic> rawApp in rawApps){
      apps.add(Applications.fromMap(rawApp));
    }

    return apps;
  }

  static Future<List<Applications>> retrieveApplicationByCategory(String categoryName) async {
    List<Applications> apps = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications", where: "appCategory = ?", whereArgs: [categoryName]), apps);
    } else {
      final Database db = await openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications", where: "appCategory = ?", whereArgs: [categoryName]), apps);
    }

    return apps;

  }

  static Future<List<Applications>> retrieveApplicationByName(String appName) async {
    List<Applications> apps = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications", where: "appName = ?", whereArgs: [appName]), apps);
    } else {
      final Database db = await openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications", where: "appName = ?", whereArgs: [appName]), apps);
    }

    return apps;

  }

  static Future<List<Applications>> retrieveAllExistingApplications() async {
    // a static method that retrieves all existing applications
    List<Applications> apps = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications"), apps);
    } else {
      final Database db = await openDatabase("store.db");
      apps = rawAppToInstances(await db.query("applications"), apps);
    }

    return apps;

  }


}