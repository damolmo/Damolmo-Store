import 'package:flutter/material.dart';
import '../../exports.dart';

class AppDetails extends StatelessWidget{
  @override
  const AppDetails({
   required this.viewModel,
   super.key
});

  final AppScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.99,
      height: getDeviceHeight(context) * 0.25,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.37,
      ),
      child: Stack(
        children: [
          // App Logo
          Container(
            width: getDeviceWidth(context) * 0.2,
            height: getDeviceHeight(context) * 0.1,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.05,
              right: getDeviceWidth(context) * 0.65
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: viewModel.backgroundColor,
              boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), spreadRadius: 3.0, blurStyle: BlurStyle.normal, blurRadius: 10.0, offset: Offset.zero)]
            ),
            child: Container(
              width: getDeviceWidth(context) * 0.18,
              height: getDeviceHeight(context) * 0.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(viewModel.app.appLogo)
                )
              ),
            ),
          ),

          // App Details
          Container(
            width: getDeviceWidth(context) * 0.7,
            margin: EdgeInsets.only(
              left: getDeviceWidth(context) * 0.3,
              top: getDeviceHeight(context) * 0.025
            ),
            decoration: BoxDecoration(),
            child: Text("${viewModel.app.appName}\n${viewModel.app.appAuthor}", style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.055, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
          ),

          Container(
            width: getDeviceWidth(context),
            height: getDeviceHeight(context) * 0.002,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.2
            ),
            decoration: BoxDecoration(
                color: viewModel.backgroundColor.withOpacity(0.6),

            ),
          ),

          // App Download/Open Buttons
          Container(
            width: getDeviceWidth(context) * 0.99,
            height: getDeviceHeight(context) * 0.07,
            margin: EdgeInsets.only(
              top: getDeviceHeight(context) * 0.12
            ),
            child: Row(
              children: [

                Container(
                  width: getDeviceWidth(context) * 0.15,
                  height: getDeviceHeight(context) * 0.07,
                  margin: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.07,
                    right: getDeviceWidth(context) * 0.07
                  ),
                  decoration: BoxDecoration(
                    color: viewModel.backgroundColor,
                    borderRadius : BorderRadius.circular(12),
                    boxShadow : [BoxShadow(color: viewModel.fontColor.withOpacity(0.6),  blurRadius: 6.0, spreadRadius: 2.0, blurStyle: BlurStyle.normal)]
                  ),
                  child: IconButton(
                    onPressed : (){
                      viewModel.shareUrl();
                  },
                    icon: Icon(Icons.share_rounded, color: viewModel.fontColor, size : 30,),
                  ),
                ),

                if (viewModel.app.appApkUrl.isNotEmpty)
                // Download Button
                InkWell(
                  onTap : (){
                    if (viewModel.downloadFileExists){
                      viewModel.installApp(viewModel.downloadPath);
                    } else {
                      viewModel.addAppToTracking(); // Track app update
                      viewModel.startAppDownload(); // Start download
                    }

                  },
                    child : Container(
                      width: viewModel.app.appWebUrl.isEmpty ? getDeviceWidth(context) * 0.65 : getDeviceWidth(context) * 0.315,
                      height: getDeviceHeight(context) * 0.07,
                      margin: EdgeInsets.only(
                        right: getDeviceWidth(context) * 0.025
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), spreadRadius: 2.0, blurStyle: BlurStyle.normal, blurRadius: 2.0)]
                      ),
                      child: Row(
                        children: [
                          // Android Icon
                          Container(
                            height : getDeviceHeight(context) * 0.05,
                            width: getDeviceWidth(context) * 0.1,
                            margin: EdgeInsets.only(
                              top: getDeviceHeight(context) * 0.01,
                              bottom: getDeviceHeight(context) * 0.01
                            ),
                            child: const Icon(Icons.android_rounded, color: Colors.white, size: 35,),
                          ),

                          // Button Text
                          Container(
                            width: getDeviceWidth(context) * 0.2,
                            height: getDeviceHeight(context) * 0.05,
                            margin: EdgeInsets.only(
                              left: viewModel.app.appWebUrl.isEmpty ? getDeviceWidth(context) * 0.15 : 0.0
                            ),
                            child: Row(children : [Text(viewModel.downloadProgress != "100%" && viewModel.downloadProgress.isNotEmpty ? viewModel.downloadProgress :  viewModel.downloadFileExists ? "Install" : "Download", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.04), textAlign: TextAlign.center,)]),
                          )
                        ],
                      ) ,
                    ),
                ),

                if (viewModel.app.appWebUrl.isNotEmpty)
                // Web Button
                InkWell(
                  onTap : (){
                  viewModel.openUrl();
                  },
                  child : Container(
                    width: getDeviceWidth(context) * 0.325,
                    height: getDeviceHeight(context) * 0.07,
                    margin: EdgeInsets.only(
                        right: getDeviceWidth(context) * 0.025
                    ),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), spreadRadius: 2.0, blurStyle: BlurStyle.normal, blurRadius: 2.0)]
                    ),
                    child: Row(
                      children: [
                        // Android Icon
                        Container(
                          height : getDeviceHeight(context) * 0.05,
                          width: getDeviceWidth(context) * 0.1,
                          margin: EdgeInsets.only(
                              top: getDeviceHeight(context) * 0.01,
                              bottom: getDeviceHeight(context) * 0.01
                          ),
                          child: const Icon(Icons.laptop_rounded, color: Colors.white, size: 35,),
                        ),

                        // Button Text
                        Container(
                          width: getDeviceWidth(context) * 0.2,
                          height: getDeviceHeight(context) * 0.05,
                          margin: EdgeInsets.only(
                          ),
                          child: Row(children : [Text("Open", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.04), textAlign: TextAlign.center,)]),
                        )
                      ],
                    ) ,
                  ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}