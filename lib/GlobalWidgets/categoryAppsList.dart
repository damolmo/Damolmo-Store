import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../exports.dart';

class CategoryAppsList extends StatelessWidget{
  @override
  const CategoryAppsList({
    required this.viewModel,
    super.key
});

  final viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
        width: getDeviceWidth(context) * 0.9,
        height: getDeviceHeight(context) * 0.8,
        margin: EdgeInsets.only(
            left: getDeviceWidth(context) * 0.05,
            right: getDeviceWidth(context) * 0.05,
            top: getDeviceHeight(context) * 0.1,
            bottom: getDeviceHeight(context) * 0.1
        ),
        child : Column(
          children: [

            // Category Banner
            Container(
              width: getDeviceWidth(context) * 0.9,
              height: getDeviceHeight(context) * 0.1,
              margin: EdgeInsets.only(
                top: getDeviceHeight(context) * 0.05
              ),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 12.0, spreadRadius: 3.0)],
                borderRadius: BorderRadius.circular(12),
                color: viewModel.backgroundColor
              ),
              child: Row(
                children: [
                  // Category Icon
                  Container(
                    width: getDeviceWidth(context) * 0.2,
                    height: getDeviceHeight(context) * 0.07,
                    margin: EdgeInsets.only(
                      top: getDeviceHeight(context) * 0.015,
                      bottom: getDeviceHeight(context) * 0.015,
                      left: getDeviceWidth(context) * 0.025
                    ),
                    child: Icon(viewModel.isCustomSearch ? Icons.search_rounded : IconData(viewModel.categories[viewModel.choosedCategory].categoryIcon, fontFamily: 'MaterialIcons'), color: Color(int.parse(viewModel.categories[viewModel.choosedCategory].categoryAccentColor.replaceAll("#", "FF"), radix: 16)), size: getDeviceWidth(context) * 0.1,),
                  ),

                  // Category Name
                  Container(
                    width: getDeviceWidth(context) * 0.5,
                    height: getDeviceHeight(context) * 0.07,
                    margin: EdgeInsets.only(
                        top: getDeviceHeight(context) * 0.015,
                        bottom: getDeviceHeight(context) * 0.015,
                        right: getDeviceWidth(context) * 0.05,
                        left: getDeviceWidth(context) * 0.025
                    ),
                    child: Row(
                      children:  [const Spacer(), Text(viewModel.isCustomSearch ? "Results" : viewModel.categories[viewModel.choosedCategory].categoryName, style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.left,), const Spacer(),
                    ]),
                  ),
                ],
              ),
            ),

            // Categories List
            Container(
                width: getDeviceWidth(context),
                height: getDeviceHeight(context) * 0.6,
                margin: EdgeInsets.only(
                  top: getDeviceHeight(context) * 0.025
                ),
                child : ListView.builder(
                itemCount: viewModel.apps.length,
                itemBuilder: (context, index){
                return InkWell(
                  onTap : (){
                    viewModel.navigateToAppPage(context, viewModel.apps[index]);
                  },
                    child : Container(
                      width: getDeviceWidth(context) * 0.85,
                      height: getDeviceHeight(context) * 0.13,
                      margin: EdgeInsets.only(
                          left: getDeviceWidth(context) * 0.025,
                          right: getDeviceHeight(context) * 0.025,
                          top: getDeviceHeight(context) * 0.025,
                          bottom: viewModel.apps.length -1 ==  index ? getDeviceHeight(context) * 0.025 : 0.0
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)],
                          borderRadius: BorderRadius.circular(10),
                          color: viewModel.backgroundColor
                      ),
                      child: ListTile(
                        leading: Image.asset(viewModel.apps[index].appLogo),
                        title: Text(viewModel.apps[index].appName, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.center,) ,
                        subtitle: Text(viewModel.apps[index].appVersion, style: TextStyle(color: viewModel.fontColor, fontSize: getDeviceWidth(context) * 0.03), textAlign: TextAlign.center,) ,
                        trailing: IconButton(
                          onPressed : (){
                            viewModel.navigateToAppPage(context, viewModel.apps[index]);
                          },

                          icon: Icon(Icons.arrow_forward_ios_rounded, color: viewModel.fontColor, size: 40,),
                        ) ,
                      )
                    ),
                );
              },
            )
            ),
          ]
        )
    );
  }

}