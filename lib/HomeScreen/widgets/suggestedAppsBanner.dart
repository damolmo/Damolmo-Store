import 'package:flutter/material.dart';
import '../../exports.dart';

class SuggestedAppsBanner extends StatelessWidget{
  @override
  const SuggestedAppsBanner({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return  Container(
      width: getDeviceWidth(context) > 580 ? getDeviceWidth(context) * 0.5 : getDeviceWidth(context) * 0.9,
      height: getDeviceWidth(context) > 580 ?  getDeviceHeight(context) * 0.35 : getDeviceHeight(context) * 0.25,
      margin : EdgeInsets.only(
        top: getDeviceHeight(context) * 0.15,
        bottom: getDeviceWidth(context) > 580 ?  getDeviceHeight(context) * 0.5 : getDeviceHeight(context) * 0.65,
        left: getDeviceWidth(context) > 580 ? getDeviceWidth(context) * 0.25 : getDeviceWidth(context) * 0.05,
        right: getDeviceWidth(context) > 580 ? getDeviceWidth(context) * 0.25 : getDeviceWidth(context) * 0.05
      ),
          child: InkWell(
            onTap :(){
              viewModel.navigateToAppPage(context, viewModel.ogApps[viewModel.currentBannerIndex]);
            },
            child :Container(
              decoration : BoxDecoration(
                  image : DecorationImage(
                      fit : BoxFit.fitWidth,
                      image : AssetImage(viewModel.ogApps.isEmpty ? "assets/apps/damolmo_store/banner.png" : viewModel.ogApps[viewModel.currentBannerIndex].appBanner)
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 15.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)]
              ),
            ),
        ),

    );
  }

}