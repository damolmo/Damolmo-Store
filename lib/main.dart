import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exports.dart';
import 'package:app_links/app_links.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DamolmoStore());

}

class DamolmoStore extends StatelessWidget{
  @override
   DamolmoStore({
    super.key
  });

 @override
 Widget build(BuildContext context){
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
   ]);
   SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeScreenView(isAppInit: true, uri: "url",),
     routes: {
     },
   );
 }
}