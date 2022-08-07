import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/components/food_category_view/food_category_view.dart';
import 'package:synoptic_restaurant_app/components/menu_category_chips/menu_category_chips.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var selected = 0;
  final pageController = PageController();
  late AccountProvider account;

  @override
  Widget build(BuildContext context) {
    var account = context.read<AccountProvider>().account;
    var menu = context.read<MenuProvider>().menu;
    var runningTotal = account.getCartTotal(menu);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Menu"),
      ),
      body: Column(
        children: [
          MenuCategoryChips(selected, (index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }),
          Expanded(child: FoodCategoryView(selected, (index) {
              setState(() {
                selected = index;
              });
              },
            pageController,
            foodTileCallback: () {
            setState(() {
              runningTotal = account.getCartTotal(menu);
            });
            },
          ),
          ),
          Text("£$runningTotal",
              style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          )),
        ],
      ),
    );
  }
}
