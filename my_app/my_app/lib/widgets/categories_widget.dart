import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2/widgets/text_widget.dart';

import '../providers/dark_theme_provider.dart';

class CategoriesWidget extends StatelessWidget {

  CategoriesWidget({Key? key,required this.catText,required this.imgPath,required this.passedColor}) : super(key: key);

  String catText,imgPath;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    double _screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
    //  Widget InWell trong Flutter là một widget được sử dụng để hiển thị nội dung trong một khung có đường viền bo tròn và một màu nền được chỉ định.
    onTap: (){
      print("Categories pressed");
    },

      child:Container(
      // height: _screenWidth * 0.3,

      decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedColor.withOpacity(0.7), width: 2)),
      child: Column(
        children: [
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath),

                  fit: BoxFit.fill
                )
            ),
          ),
          TextWidget(text: catText, color: color, textSize: 20,isTitle:true ,)
        ],
      ),
    ));
  }
}
