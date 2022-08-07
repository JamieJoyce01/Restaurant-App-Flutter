import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';
import 'package:synoptic_restaurant_app/screens/admin_page/admin_page.dart';
import 'package:synoptic_restaurant_app/screens/book_table_page/book_table_page.dart';
import 'package:synoptic_restaurant_app/screens/current_order_page/current_order_page.dart';
import 'package:synoptic_restaurant_app/screens/home_page/lib/home_page.dart';
import 'package:synoptic_restaurant_app/screens/login_page/lib/login_page.dart';
import 'package:synoptic_restaurant_app/screens/menu_page/lib/menu_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AccountProvider()),
    ChangeNotifierProvider(create: (_) => MenuProvider())
  ],
  child:const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/menu': (context) => const MenuPage(),
        '/book': (context) => const BookTablePage(),
        '/order': (context) => const CurrentOrderPage(),
        '/admin': (context) => const AdminPage()
      },
      debugShowCheckedModeBanner: false,
      title: 'BurgerBey',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: COLOUR_SCHEME_YELLOW,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: COLOUR_SCHEME_YELLOW,
        ),
        fontFamily: 'Palatino',
        scaffoldBackgroundColor: COLOUR_SCHEME_WHITE,
        buttonTheme: const ButtonThemeData(
          buttonColor: COLOUR_SCHEME_YELLOW
        )
      ),
    );
  }
}

