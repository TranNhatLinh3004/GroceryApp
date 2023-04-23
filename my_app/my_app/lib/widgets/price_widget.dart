import 'package:flutter/material.dart';
import 'package:test2/widgets/text_widget.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key,required this.salePrice,required this.price,required this.textPrice,required this.isOnSale}) : super(key: key);

  final int salePrice,price;
  final String textPrice;
  final bool isOnSale;


  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    int userPrice = isOnSale ? salePrice : price;

    return FittedBox(
      child: Row(
        children: [
          TextWidget(text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}', color: Colors.green, textSize: 22),
          SizedBox(width: 6,),
         Visibility(visible: isOnSale ? true:false, child:  Text('\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',style: TextStyle(fontSize: 15,color: color,decoration: TextDecoration.lineThrough),)
         )],
      ),

    );
  }
}
