import '../exports.dart';

class ThemesData{

  static Map<String,dynamic> themesMap = {
    "black" : {
      "themeBackgroundColor" : "FF000000",
      "themeFontColor" : "FFFFFFFF"
    },

    "light" : {
      "themeBackgroundColor" : "FFFFFFFF",
      "themeFontColor" : "FF000000"
    },

    "pink" : {
      "themeBackgroundColor" : "FFd341c0",
      "themeFontColor" : "FFFFFFFF"
    },

    "purple" : {
      "themeBackgroundColor" : "FF9f03c4",
      "themeFontColor" : "FFFFFFFF"
    },

    "blue" : {
      "themeBackgroundColor" : "FF2196F3",
      "themeFontColor" : "FFFFFFFF"
    },

    "green" : {
      "themeBackgroundColor" : "FF81C784",
      "themeFontColor" : "FFFFFFFF"
    },

    "turquoise" : {
      "themeBackgroundColor" : "FF40C4FF",
      "themeFontColor" : "FFFFFFFF"
    },

    "yellow" : {
      "themeBackgroundColor" : "FFf6f661",
      "themeFontColor" : "FFFFFFFF"
    },

    "orange" : {
      "themeBackgroundColor" : "FFFFAB40",
      "themeFontColor" : "FFFFFFFF"
    },

    "grey" : {
      "themeBackgroundColor" : "FF9E9E9E",
      "themeFontColor" : "FFFFFFFF"
    },
  };

  static insertNewThemes() async {
    // Insert themes into the database

    Themes.createThemesData(); // To be executed once!

    for (String themeName in themesMap.keys){
      Themes.insertThemeIntoTable(
          Themes(
              themeName: themeName,
              themeBackgroundColor: themesMap[themeName]["themeBackgroundColor"],
              themeFontColor: themesMap[themeName]["themeFontColor"]));
    }
  }

}