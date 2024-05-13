import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exports.dart';
import 'package:app_links/app_links.dart';

void main(){
  final _appLinks = AppLinks();
  _appLinks.uriLinkStream.listen((uri) {
    // Listen to user uri
    if (uri.path.isNotEmpty){
      runApp(DamolmoStore(uri: uri.path,));
    }
  });
  runApp(const DamolmoStore(uri: "",));

}

class DamolmoStore extends StatelessWidget{
  @override
  const DamolmoStore({
    required this.uri,
    super.key
  });

  final String uri;

 @override
 Widget build(BuildContext context){
   SystemChrome.setPreferredOrientations([
     DeviceOrientation.portraitUp,
   ]);
   SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: getDeviceWidth(context) < 580 ?  HomeScreenView(isAppInit: true, uri: uri,) : Container() ,
     routes: {
     },
   );
 }
}