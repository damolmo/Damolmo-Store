import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Categories{

  Categories({
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryAccentColor
});

  final String categoryName;
  final int categoryIcon;
  final String categoryAccentColor;

  static const categoriesTable = """
    CREATE TABLE IF NOT EXISTS categories(
      categoryName TEXT PRIMARY KEY,
      categoryIcon INTEGER,
      categoryAccentColor TEXT
    );
  """;

  Map<String,dynamic> toMap() => {"categoryName" : categoryName, "categoryIcon" : categoryIcon, "categoryAccentColor" : categoryAccentColor};
  factory Categories.fromMap(Map<String,dynamic> map) => Categories(categoryName: map["categoryName"], categoryIcon: map["categoryIcon"], categoryAccentColor: map["categoryAccentColor"]);


  static createCategoriesTable() async {
    // A static method that allow us to create the categories table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    } else {
      final Database db = await openDatabase("store.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    }
  }

  static insertCategoryIntoTable(Categories category) async {
    // A static method that allow us to insert new categories
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      db.insert("categories", category.toMap());
    } else {
      final Database db = await openDatabase("store.db");
      db.insert("categories", category.toMap());
    }
  }

  static Future<List<Categories>> retrieveExistingCategories() async {
    // A static method that retrieves existing categories

    rawCategoryToInstances(List<Map<String,dynamic>> rawCategories, List<Categories> categories) {
      for (Map<String,dynamic> rawCategory in rawCategories){
        categories.add(Categories.fromMap(rawCategory));
      }

      return categories;
    }

    List<Categories> categories = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("store.db");
      categories = rawCategoryToInstances(await db.query("categories"), categories);
    } else {
      final Database db = await openDatabase("store.db");
      categories = rawCategoryToInstances(await db.query("categories"), categories);
    }

    return categories;
  }

}