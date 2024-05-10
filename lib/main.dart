import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exports.dart';

void main() => runApp(const DamolmoStore());

class DamolmoStore extends StatelessWidget{
  @override
  const DamolmoStore({super.key});

 @override
 Widget build(BuildContext context){
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
   ]);
   SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
   return const MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomeScreenView(isDarkModeEnabled: false,),
     routes: {
     },
   );
 }
}