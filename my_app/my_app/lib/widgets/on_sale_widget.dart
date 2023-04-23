import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:test2/widgets/heart_btn.dart';
import 'package:test2/widgets/price_widget.dart';
import 'package:test2/widgets/text_widget.dart';

import '../services/utils.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;


  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          // "name": qn.docs[i]["name"],
          //
          // "age": qn.docs[i]["age"],

          "id": qn.docs[i]["id"],
          "title": qn.docs[i]["title"],
          "imageUrl": qn.docs[i]["imageUrl"],
          //
          "categoryName": qn.docs[i]["categoryName"],
          "isProductOnSale": qn.docs[i]["isProductOnSale"],
          //
          "price": qn.docs[i]["price"],
          "salePrice": qn.docs[i]["salePrice"],
          "isPiece": qn.docs[i]["isPiece"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    return Padding(
        padding: EdgeInsets.all(9.0),
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://images.unsplash.com/photo-1531730724745-a8d774fd1e64?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                          height: size.height * 0.12,
                          width: size.width * 0.22,
                          // boxFit: BoxFit.cover,
                        ),
                        // Image.asset(
                        //   'assets/images/cherries.jpg',
                        // ),
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          children: [
                            TextWidget(
                                text: '1KG',
                                color: color,
                                textSize: 22,
                                isTitle: true),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    size: 22,
                                    color: color,
                                    IconlyLight.bag2,
                                  ),
                                ),
                                HeartBTN()
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    const PriceWidget(

                      salePrice: 2,
                      price: 5,
                      textPrice: '1',
                      isOnSale: true,
                    ),
                    // const SizedBox(height: 5,),
                    TextWidget(
                        text: 'Product title',
                        color: color,
                        textSize: 18,
                        isTitle: true),
                    const SizedBox(
                      height: 5,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
