import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, imageUrl, categoryName;
  final double price, salePrice;
  final bool isProductOnSale, isPiece;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.categoryName,
      required this.price,
      required this.salePrice,
      required this.isProductOnSale,
      required this.isPiece});
}
