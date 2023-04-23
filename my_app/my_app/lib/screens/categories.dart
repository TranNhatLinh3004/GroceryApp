import 'package:flutter/material.dart';
import 'package:test2/widgets/categories_widget.dart';
import 'package:test2/widgets/text_widget.dart';

import '../services/utils.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);
  List <Color> girdColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44c),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),

  ];
  List catInfo = [
    {'imgPath': 'assets/images/fruits.png', 'catInfo': 'Fruits'},
    {'imgPath': 'assets/images/grains.png', 'catInfo': 'Vegetable'},
    {'imgPath': 'assets/images/nuts.png', 'catInfo': 'Herbs'},
    {'imgPath': 'assets/images/spices.png', 'catInfo': 'Nuts'},
    {'imgPath': 'assets/images/veg.png', 'catInfo': 'Fruits'},
    {'imgPath': 'assets/images/Spinach.png', 'catInfo': 'Fruits'},

  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          //nó được sử dụng để tạo ra hiệu ứng bóng đổ hoặc để định vị các widget trên các lớp khác nhau.
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Categories',
            color: color,
            textSize: 24,
            isTitle: true,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 240 / 250,
              crossAxisSpacing: 10,

              // thẳng đứng

              mainAxisSpacing: 10,
                // nằm ngang

                children: List.generate(6, (index) {
                return CategoriesWidget(
                  catText: catInfo[index]['catInfo'],
                  imgPath: catInfo[index]['imgPath'],
                  passedColor: girdColors[index],
                );
              }),
            )));
  }
}
