import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test2/inner_screens/feeds_screen.dart';
import 'package:test2/inner_screens/on_sale_screen.dart';
import 'package:test2/providers/dark_theme_provider.dart';
import 'package:test2/providers/products_provider.dart';
import 'package:test2/screens/auth/login.dart';
import 'package:test2/screens/auth/register.dart';
import 'package:test2/screens/btn_bottom_bar.dart';
import 'package:test2/screens/home.dart';
import 'package:test2/screens/product_detail.dart';

import 'consts/theme_data.dart';
import 'models/products_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = true;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ProductsProvider()),

                // Thêm các Provider khác nếu cần thiết
              ],
              child: MaterialApp(
                // Remove the debug banner
                debugShowCheckedModeBanner: false,
                title: '',
                theme: Style.themeData(themeProvider.getDarkTheme, context),
                home: BottomBar(),
                routes: {
                  OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                  FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                  LoginScreen.routeName: (ctx) => const LoginScreen(),
                  RegisterScreen.routeName: (ctx) => const RegisterScreen(),

                  // DetailProduct.routeName: (ctx) => const DetailProduct()
                },
              ));
        }));
  }
}
