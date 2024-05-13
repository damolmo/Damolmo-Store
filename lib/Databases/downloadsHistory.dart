import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

class DownloadsHistory {

  DownloadsHistory({
    required this.downloadName,
    required this.downloadIcon,
    required this.downloadPath,
    required this.downloadDate
});

  final String downloadName;
  final String downloadIcon;
  final String downloadPath;
  final String downloadDate;

  static const downloadsHistoryTable = """
    CREATE TABLE IF NOT EXISTS downloadsHistory(
      downloadName TEXT,
      downloadIcon TEXT,
      downloadPath TEXT,
      downloadDate TEXT PRIMARY KEY,
      FOREIGN KEY(downloadName) REFERENCES applications(appName),
      FOREIGN KEY(downloadIcon) REFERENCES applications(appLogo)
    );
  """;

  Map<String,dynamic> toMap() => {"downloadName": downloadName, "downloadIcon" : downloadIcon, "downloadPath" : downloadPath, "downloadDate" : downloadDate};

  factory DownloadsHistory.fromMap(Map<String,dynamic> map) =>
    DownloadsHistory(
        downloadName: map["downloadName"],
        downloadIcon: map["downloadIcon"],
        downloadPath: map["downloadPath"],
        downloadDate: map["downloadDate"]);

  static createDownloadsTable() async {
    // A static method that creates the downloads table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(downloadsHistoryTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(downloadsHistoryTable));
    }
  }

  static insertDownloadIntoTable(DownloadsHistory download) async {
    // A static method that inserts a new download into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("downloadsHistory", download.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("downloadsHistory", download.toMap());
    }
  }

  static deleteSingleDownload(DownloadsHistory download) async {
    // A static method that allow us to drop a specific download
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.delete("downloadsHistory", where: "downloadDate = ?", whereArgs: [download.downloadDate]);
    } else {
      final Database db = await openDatabase("store.db");
      db.delete("downloadsHistory", where: "downloadDate = ?", whereArgs: [download.downloadDate]);
    }
  }

  static Future<List<DownloadsHistory>> retrieveCurrentDownloads() async {
    // A static method that retrieves current downloads

    rawDownloadToInstance(List<Map<String,dynamic>> rawDownloads, List<DownloadsHistory> downloads){
      for (Map<String,dynamic> rawDownload in rawDownloads){
        downloads.add(DownloadsHistory.fromMap(rawDownload));
      }

      return downloads;
    }

    List<DownloadsHistory> downloads = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      downloads = rawDownloadToInstance(await db.query("downloadsHistory"), downloads);
    } else {
      final Database db = await openDatabase("store.db");
      downloads = rawDownloadToInstance(await db.query("downloadsHistory"), downloads);
    }

    return downloads;
  }


}