import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:test2/inner_screens/feeds_screen.dart';
import 'package:test2/inner_screens/on_sale_screen.dart';
import 'package:test2/widgets/on_sale_widget.dart';
import 'package:test2/widgets/text_widget.dart';

import '../models/products_model.dart';
import '../providers/products_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/feed_item.dart';
import '../widgets/heart_btn.dart';
import '../widgets/price_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  // Future<void> fetchProducts() async {
  //   try {
  //     final productsSnapshot =
  //     await FirebaseFirestore.instance.collection('products').get();
  //     _products = productsSnapshot.docs.map((doc) => ProductModel(
  //         id: doc.get('id'),
  //         title: doc.get('title'),
  //         imageUrl: doc.get('imageUrl'),
  //         categoryName: doc.get('categoryName'),
  //         price: double.parse(doc.get('price')),
  //         salePrice: doc.get('salePrice'),
  //         isProductOnSale: doc.get('isProductOnSale'),
  //         isPiece: doc.get('isPiece')
  //     )).toList();
  //     // notifyListeners();
  //   } catch (error) {
  //     print(error);
  //   }
  // }


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

/*
*
* Đoạn code trên thực hiện việc lấy dữ liệu ảnh cho carousel slider từ Firebase Firestore.

Cụ thể, hàm fetchCarouselImages() sử dụng phương thức collection() để tham chiếu đến collection "carousel-slider" trong Firebase Firestore, sau đó gọi phương thức get() để lấy tất cả các documents trong collection đó.

Khi có dữ liệu trả về, hàm sử dụng setState() để cập nhật state _carouselImages bằng cách lặp qua tất cả các documents đã lấy được từ Firebase Firestore và thêm đường dẫn ảnh của từng document vào state _carouselImages. Hàm cũng in ra đường dẫn ảnh của mỗi document để kiểm tra.

Cuối cùng, hàm trả về một danh sách các documents đã lấy được từ Firebase Firestore.
*
* */

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;

    final productProviders = Provider.of<ProductsProvider>(context);

    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;

    // GlobalMethods globalMethods =  GlobalMethods();
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [
        SizedBox(
          height: size.height * 0.33,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                _carouselImages[index],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: _carouselImages.length,
            pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white, activeColor: Colors.red)),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        TextButton(
            onPressed: () {
              print(_products.length);
              GlobalMethods.navigateTo(
                  ctx: context, routeName: OnSaleScreen.routeName);
            },
            child: TextWidget(
              text: 'View All',
              color: Colors.blue,
              textSize: 22,
              maxLines: 1,
            )),
        // SizedBox(
        //   height: 3,
        // ),
        Row(
          children: [
            RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                        text: 'On sale '.toUpperCase(),
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      IconlyLight.discount,
                      color: Colors.red,
                    )
                  ],
                )),
            SizedBox(
              width: 8,
            ),
            Flexible(
              child: SizedBox(
                height: size.height * 0.24,
                child: ListView.builder(
                    itemCount:
                    _products.where((product) => product['isProductOnSale'] != false).length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      // if(_products[index]['isProductOnSale'] == true)
                   final  _product = _products.where((product) => product['isProductOnSale'] != false).toList();
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
                                          Image.network(_product[index]['imageUrl'],
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
                                       PriceWidget(

                                        salePrice: _product[index]['salePrice'] ,
                                        price: _product[index]['price'] ,
                                        textPrice: '1',
                                        isOnSale: _product[index]['isProductOnSale'] ,
                                      ),
                                      // const SizedBox(height: 5,),
                                      TextWidget(
                                          text: _product[index]['title'],
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

              ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
                text: 'Our products',
                color: color,
                textSize: 22,
                isTitle: true),
            TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: FeedsScreen.routeName);
                },
                child: TextWidget(
                  text: 'Browse',
                  color: Colors.blue,
                  textSize: 22,
                  isTitle: true,
                ))
          ],
        ),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          // crossAxisSpacing: 10,
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: size.width / (size.height * 0.6),
          children: List.generate(
              _products.length < 10
                  ? _products.length // length 3
                  : 10, (index) {

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
                        Image.network(_products[index]['imageUrl'],
                          // imageUrl: productModel.imageUrl,
                          //
                          // // imageUrl: 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
                          // // errorWidget: Image.asset('assets/images/cherries.jpg'),
                          height: size.height * 0.12,
                          width: size.width * 0.22,
                          fit: BoxFit.cover,
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
                                    text: _products[index]['title'],
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


                                  salePrice: _products[index]['salePrice'],
                                  price: _products[index]['price'],
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

                                          // controller: _quantifyTextController,
                                          key: const ValueKey('10'),
                                          style: TextStyle(color: color,fontSize: 18),
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          enabled: true,
                                          inputFormatters: [
                                            // FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
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


          }),
        ),
      ],
    ))));
  }
}
