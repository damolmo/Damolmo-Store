import 'package:flutter/material.dart';
import '../../exports.dart';

class CategoryApps extends StatelessWidget{
  @override
  const CategoryApps({
    required this.viewModel,
    super.key
});

  final HomeScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) * 0.8,
      height: getDeviceHeight(context) * 0.4,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) * 0.1,
        right: getDeviceWidth(context) * 0.1,
        top: getDeviceHeight(context) * 0.4,
        bottom: getDeviceHeight(context) * 0.2
      ),
      child: ListView.builder(
          itemCount: viewModel.categories.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap : (){
                viewModel.isCategorySelected = true;
                viewModel.choosedCategory = index;
                viewModel.notifyListeners();
                viewModel.getAppsByCategory(viewModel.categories[index].categoryName);
              },
                child : Container(
                  width: getDeviceWidth(context) * 0.75,
                  height: getDeviceHeight(context) * 0.1,
                  margin: EdgeInsets.only(
                    left: getDeviceWidth(context) * 0.025,
                    right: getDeviceWidth(context) * 0.025,
                    top: getDeviceHeight(context) * 0.03
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: viewModel.fontColor.withOpacity(0.6), blurRadius: 10.0, blurStyle: BlurStyle.normal, spreadRadius: 3.0)],
                    color: viewModel.backgroundColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      // Category Icon
                      Container(
                        width: getDeviceWidth(context) * 0.15,
                        height: getDeviceHeight(context) * 0.1,
                        margin: EdgeInsets.only(
                          left: getDeviceWidth(context) * 0.025,
                          right: getDeviceWidth(context) * 0.025
                        ),
                        child: Icon(IconData(viewModel.categories[index].categoryIcon, fontFamily: "MaterialIcons"), color: Color(int.parse(viewModel.categories[index].categoryAccentColor.replaceAll("#", "FF"), radix : 16)), size: 45,),
                      ),

                      // Category Name
                      Container(
                        width: getDeviceWidth(context) * 0.52,
                        height: getDeviceHeight(context) * 0.1,
                        margin: EdgeInsets.only(
                          right: getDeviceWidth(context) * 0.025
                        ),
                        child: Row(
                          children: [
                            Text(viewModel.categories[index].categoryName, style: TextStyle(color: viewModel.fontColor, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06), textAlign: TextAlign.left ,),
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}