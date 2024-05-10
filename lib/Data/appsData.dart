import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../exports.dart';

class AppsData{

  static List<dynamic> appsMap = [];

  static getLatestData() async {
    // A method with the purpose of getting the latest data and saving it into a variable
    var data = await http.get(Uri.parse('https://raw.githubusercontent.com/damolmo/damolmo/main/data.txt'));
    appsMap = json.decode(data.body);
    checkDatabaseData();
  }

  static checkDatabaseData() async {
    // Checks what apps need an update
    List<Applications> oldApps =[];

    try {
      oldApps = await Applications.retrieveAllExistingApplications();
      updateApps();
    } catch (e){
      insertNewApp();
    }
  }

  static updateApps() async {
    // Updates current apps with new data
    for (Map<String,dynamic> rawApp in appsMap){
      try {
        Applications.updateExistingApplication(Applications.fromMap(rawApp));
      } catch (e){
        Applications.insertAppIntoTable(Applications.fromMap(rawApp));
      }
    }
  }

  static insertNewApp() async {
    // A method that allow us to insert new apps into the database

    Applications.createApplicationsTable(); // To be executed once

    for (Map<String,dynamic> rawApp in appsMap){
      Applications.insertAppIntoTable(Applications.fromMap(rawApp));
    }
  }

}