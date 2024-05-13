import 'package:flutter/material.dart';
import '../../exports.dart';

class DownloadsList extends StatelessWidget{
  @override
  const DownloadsList({
    required this.viewModel,
    super.key
});

  final DownloadsScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.9,
      height: getDeviceHeight(context) * 0.55,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.27,
        bottom: getDeviceHeight(context) * 0.15,
        left: getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) * 0.05
      ),
      child: ListView.builder(
          itemCount: viewModel.downloads.length,
          itemBuilder: (context, index){
            return Container(
                child : Stack(
                  children: [
                    // File Details Container
                    if (viewModel.isDownloadDetails && viewModel.choosedDownloadIndex == index)
                    Container(
                      width: getDeviceWidth(context) * 0.85,
                      height: getDeviceHeight(context) * 0.1,
                      margin: EdgeInsets.only(
                          top: getDeviceHeight(context) * 0.18,
                          bottom: getDeviceHeight(context) * 0.015,
                          left: getDeviceWidth(context) * 0.025,
                          right: getDeviceWidth(context) * 0.025
                      ),
                      decoration: BoxDecoration(
                          color: viewModel.backgroundColor,
                          borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          // Download Install
                          InkWell(
                            onTap : (){
                              viewModel.installUserFile(viewModel.downloads[index]);
                            },
                            child : Container(
                            width: getDeviceWidth(context) * 0.4,
                            height: getDeviceHeight(context) * 0.07,
                            margin: EdgeInsets.only(
                              top: getDeviceHeight(context) * 0.015,
                              bottom: getDeviceHeight(context) * 0.015,
                              right: getDeviceWidth(context) * 0.025,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              boxShadow: [BoxShadow(color: viewModel.fontColor, blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text("Install", style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.center,),
                                const Spacer(),
                              ],
                            )  ),
                          ),

                          // Download Remove
                          InkWell(
                            onTap : (){
                              viewModel.deleteUserFile(viewModel.downloads[index]);
                            },
                            child : Container(
                              width: getDeviceWidth(context) * 0.4,
                              height: getDeviceHeight(context) * 0.07,
                              margin: EdgeInsets.only(
                                  top: getDeviceHeight(context) * 0.015,
                                  bottom: getDeviceHeight(context) * 0.015,
                                  left: getDeviceWidth(context) * 0.025
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  boxShadow: [BoxShadow(color: viewModel.fontColor, blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text("Delete", style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.center,),
                                  const Spacer(),
                                ],
                                )
                             ),
                          ),
                        ],
                      ),
                    ),

                      // File Container
                    Container(
                      width: getDeviceWidth(context) * 0.8,
                      height: getDeviceHeight(context) * 0.15,
                      margin: EdgeInsets.only(
                        top: getDeviceHeight(context) * 0.012,
                        left: getDeviceWidth(context) * 0.05,
                        right: getDeviceWidth(context) * 0.05,
                        bottom: getDeviceHeight(context) * 0.012
                      ),
                      decoration: BoxDecoration(
                        color: viewModel.backgroundColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 6.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)]
                      ),
                      child: Row(
                        children: [
                          // Download Logo
                          Container(
                            width: getDeviceWidth(context) * 0.30,
                            height: getDeviceHeight(context) * 0.10,
                            margin: EdgeInsets.only(
                              top: getDeviceHeight(context) * 0.025,
                              bottom: getDeviceHeight(context) * 0.025
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(viewModel.downloads[index].downloadIcon)
                              )
                            ),
                          ),

                          // Download Name
                          Container(
                            height: getDeviceHeight(context) * 0.15,
                            width: getDeviceWidth(context) * 0.25,
                            margin: EdgeInsets.only(
                              left: getDeviceWidth(context) * 0.05,
                              right: getDeviceWidth(context) * 0.05
                            ),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(viewModel.downloads[index].downloadName, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                const Spacer(),
                              ],
                            ),
                          ),

                          // Download Details Button
                          SizedBox(
                            width: getDeviceWidth(context) * 0.1,
                            height: getDeviceHeight(context) * 0.15,
                            child: IconButton(
                              onPressed : (){
                                viewModel.isDownloadDetails ? viewModel.isDownloadDetails = false : viewModel.isDownloadDetails = true;
                                viewModel.choosedDownloadIndex =  index;
                                viewModel.notifyListeners();
                                },
                              icon: Icon(Icons.keyboard_arrow_down_rounded, size: 45, color: viewModel.fontColor.withOpacity(0.8),),
                            ),
                          )
                        ],
                      ),
                    ),
              ],
            )
            );
           },
      ),
    );
  }

}