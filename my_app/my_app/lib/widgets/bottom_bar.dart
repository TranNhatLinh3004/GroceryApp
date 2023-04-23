import 'package:flutter/material.dart';
import 'package:test2/widgets/text_widget.dart';

import '../services/utils.dart';

class ItemBottomBar extends StatefulWidget {
  const ItemBottomBar({Key? key}) : super(key: key);

  @override
  State<ItemBottomBar> createState() => _ItemBottomBarState();
}

class _ItemBottomBarState extends State<ItemBottomBar> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    return

      Container(
      color: Color(0xFFF5F9FD),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child:

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                  color: Color(0xFF475269),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Material(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextWidget(
                          text: 'Order now',
                          textSize: 20,
                          color: color,
                          isTitle: true,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                      child: TextWidget(
                    text: 'Total: \$0.255',
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
