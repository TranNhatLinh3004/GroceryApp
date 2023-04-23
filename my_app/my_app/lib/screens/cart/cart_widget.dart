import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test2/widgets/heart_btn.dart';
import 'package:test2/widgets/text_widget.dart';

import '../../services/utils.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    return GestureDetector(




        child: Row(children: [
          Expanded(child: Padding(
        padding: EdgeInsets.all(4.0)
          ,
         child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12)
        ),
        child:Row(
        children:[
      Container(

        height: size.width * 0.22,
        width: size.width * 0.21,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        child: FancyShimmerImage(
          imageUrl:
              'https://images.pexels.com/photos/708777/pexels-photo-708777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          // height: size.height * 0.21,
          // width: size.width * 0.2,
          boxFit: BoxFit.cover,
        ),
      ),

      SizedBox(width: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Padding(padding: EdgeInsets.only(left: 5)
         , child:  TextWidget(
               text: 'Title',
               color: color,
               textSize: 20,
               isTitle: true,
             ),
         ),
          SizedBox(
            height: 16.0,
          ),
          SizedBox(
              width: 100,
              child: Row(
                children: [
                  _quantityController(
                      fct: () {},
                      icon: CupertinoIcons.minus,
                      color: Colors.red),

                  Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _quantityTextController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            focusedBorder:
                                UnderlineInputBorder(borderSide: BorderSide())),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        onChanged: (v) {
                          setState(() {
                            if (v.isEmpty) {
                              _quantityTextController.text = '1';
                            } else {
                              return;
                            }
                          });
                        },
                      )),
                  _quantityController(
                      fct: () {},
                      icon: CupertinoIcons.plus,
                      color: Colors.green)

                  // Flexible(
                  //     flex: 2,
                  //     child: Material(
                  //       color: color,
                  //       borderRadius: BorderRadius.circular(12),
                  //       child: InkWell(
                  //         borderRadius: BorderRadius.circular(12),
                  //         onTap: () {},
                  //         child: const Icon(
                  //           Icons.plus_one,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ))
                ],
              ))
        ],
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: const Icon(
                CupertinoIcons.cart_badge_minus,
                color: Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            HeartBTN(),
            TextWidget(text: '\$0.29', color: color, textSize: 18, maxLines: 1),
          ],
        ),
      )
    ]
        )
    )))]));
  }

  Widget _quantityController(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
        flex: 2,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Material(
              color: color,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    fct();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  )),
            )));
  }
}
