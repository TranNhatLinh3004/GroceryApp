import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test2/widgets/heart_btn.dart';
import 'package:test2/widgets/price_widget.dart';
import 'package:test2/widgets/text_widget.dart';

import '../models/products_model.dart';
import '../screens/product_detail.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _quantifyTextController = TextEditingController();

  @override
  void initState() {
    _quantifyTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantifyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    final Color color = Utils(context).color;

    Size size = Utils(context).getScreenSize;





    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              // GlobalMethods.navigateTo(ctx:context,routeName:DetailProduct.routeName);

            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                FancyShimmerImage(
                  imageUrl: productModel.imageUrl,

                  // imageUrl: 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                  errorWidget: Image.asset('assets/images/cherries.jpg'),
                  height: size.height * 0.12,
                  width: size.width * 0.22,
                  boxFit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text: 'Title',
                            color: color,
                            textSize: 20,
                            isTitle: true),
                        HeartBTN()
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    // vertical: 5,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Flexible(
                        flex: 4,
                        child:

                       PriceWidget(


                        salePrice: 2,
                        price: 5,
                        textPrice: "1",
                        isOnSale: true,
                      ),
                      // const SizedBox(
                      //   width: 8,
                      ),
                      Flexible(
                          child: Row(
                        children: [
                          FittedBox(
                            child: TextWidget(
                                text: 'Kg',
                                color: color,
                                textSize: 15,
                                isTitle: true),
                          ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // TextField(),
                          SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            flex: 2,
                            child: TextFormField(

                              controller: _quantifyTextController,
                              key: const ValueKey('10'),
                              style: TextStyle(color: color,fontSize: 18),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              enabled: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                              ],
                            ),
                          )
                        ],
                      )
                      )
                    ],
                  ),
                ),
                 Spacer(),
                SizedBox(
                  child:
                TextButton(onPressed: (){}, child: TextWidget(

                  text: 'Add to cart',
                  color: color,
                  maxLines: 1,
                  textSize: 20,
                ),


                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(


                    Theme.of(context).cardColor),

                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(

                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0)
                      )
                    )
                  )
                  ),
                ),



                )],
            ),
          ),
        ));
  }
}
