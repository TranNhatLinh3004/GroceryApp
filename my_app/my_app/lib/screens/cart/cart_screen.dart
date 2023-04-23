import 'package:flutter/material.dart';
import 'package:test2/screens/cart/cart_widget.dart';
import 'package:test2/widgets/text_widget.dart';

import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Cart(2)',
            color: color,
            textSize: 22,
            isTitle: true,
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: color,))],
        ),
        body: Column(children: [
          checkout(ctx:context),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return CartWidget();
              },
            ),
          )
        ]

        )


    );
  }

  Widget checkout({required BuildContext ctx}) {
    final Color color = Utils(ctx).color;

    final Utils utils = Utils(ctx);

    final themeState = utils.getTheme;
    Size size = Utils(ctx).getScreenSize;
    return Container(

      width: double.infinity,
      height: size.height * 0.1,

      // color: color,
      child: Padding(
          padding: EdgeInsets.all(8.0),
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
           Flexible(child:  TextWidget(text: 'Total: \$0.255', color: color, textSize: 20,isTitle: true,)
           )],
          )
      )

    );

  }
}
