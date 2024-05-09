import 'package:flutter/material.dart';
import '../exports.dart';

class CategoriesData{

  static Map<String,dynamic> categoriesMap = {
    "Entertainment" : {
      "categoryIcon" : Icons.music_note_rounded.codePoint,
      "categoryAccentColor" : "#fc58d9"
    },

    "Communication" : {
      "categoryIcon" : Icons.message_rounded.codePoint,
      "categoryAccentColor" : "#586ffc"
    },

    "Tools" : {
      "categoryIcon" : Icons.construction.codePoint,
      "categoryAccentColor" : "#f69726"
    },

  };

  static insertNewCategory() async {
    // A static method that inserts brand new categories into the database
    Categories.createCategoriesTable(); // To be executed once(?)

    for (String category in categoriesMap.keys){
      Categories.insertCategoryIntoTable(Categories(categoryName: category, categoryIcon: categoriesMap[category]["categoryIcon"], categoryAccentColor: categoriesMap[category]["categoryAccentColor"]));
    }
  }

}