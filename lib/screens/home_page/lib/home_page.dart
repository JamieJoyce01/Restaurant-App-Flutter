import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/components/menu_button/menu_button.dart';
import 'package:synoptic_restaurant_app/constants/strings.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_summary.dart';
import 'package:synoptic_restaurant_app/main_classes/menu/menu.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context, listen: false).account;
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Center(child: Text(appTitle)),
          actions: [
            IconButton(onPressed: () {
              if(account.isAdmin) {
                Navigator.pushNamed(context, '/admin');
              }
            }, icon: ImageIcon(AssetImage('assets/restaurant.png'))),
          ],
        ),
        body: SingleChildScrollView(
          child:Column(children: [
            const SizedBox(height: 10,),
            Text("Welcome ${account.username}!", style: const TextStyle(fontSize: 25)),
            MenuButton(buttonImage: const AssetImage("assets/9c.jpg"),
              buttonText: "Menu",
              onPressed: () async => {
                Navigator.pushNamed(context, '/menu')
              },
            ),
            MenuButton(buttonImage: const AssetImage("assets/9l.jpg"), buttonText: "Book a Table", onPressed: () => {
              Navigator.pushNamed(context, '/book')
            }),
            MenuButton(buttonImage: const AssetImage("assets/7.jpg"), buttonText: "Current Order", onPressed: () async => {
              Provider.of<MenuProvider>(context, listen: false).setCurrentOrder(FoodItemSummary
                  .processCartForCurrentOrder(account.formatCartToList(menuProvider.menu), account.cart)),
              Navigator.pushNamed(context, '/order')
            })
          ],
          ),
        )



      );
  }
}