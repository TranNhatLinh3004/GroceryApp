import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../services/utils.dart';
import '../widgets/feed_item.dart';
import '../widgets/on_sale_widget.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreen";

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final _searchTextController = TextEditingController();

  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void initState() {
    // _searchTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    final Color color = Utils(context).color;

    final Utils utils = Utils(context);

    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
            text: 'All Products',
            textSize: 24.0,
            color: color,
            isTitle: true),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [

        Padding(padding: const EdgeInsets.all(8.0)
        ,child: SizedBox(
        height:kBottomNavigationBarHeight
        , child:
      TextField(
        focusNode: _searchTextFocusNode,
        controller: _searchTextController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            const BorderSide(color: Colors.greenAccent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            const BorderSide(color: Colors.greenAccent, width: 1),
          ),
          hintText: 'What is in your mind ',
          prefixIcon: const Icon(Icons.search),

          suffix: IconButton(
            onPressed: () {
              _searchTextController.clear();
              _searchTextFocusNode.unfocus();
            },
            icon: Icon(
              Icons.close,
              color: _searchTextFocusNode.hasFocus ? Colors.red : color,
            ),
          ),
        ),
      ))),
        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          // crossAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: size.width / (size.height * 0.6),
          children: List.generate(4, (index) {
            return FeedWidget();
          }),
        )
        ],
      ),
      // body: _isEmpty
      //     ? Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       children: [
      //         Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Image.asset('assets/images/box.png')),
      //         Text('No products on sale yet! \nStay tuned',
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontWeight: FontWeight.w700, color: color, fontSize: 24,
      //             ))
      //       ],
      //     ),
      //   ),
      // )
      //     : GridView.count(
      //   padding: EdgeInsets.zero,
      //   crossAxisCount: 2,
      //   // crossAxisSpacing: 10,
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   childAspectRatio: size.width / (size.height * 0.6),
      //   children: List.generate(4, (index) {
      //     return OnSaleWidget();
      //   }),
      // ),
    ));
  }
}
