import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/components/food_item_summary_tile/food_item_summary_tile.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';
import 'package:synoptic_restaurant_app/providers/menu_provider.dart';

class CurrentOrderPage extends StatefulWidget {
  const CurrentOrderPage({Key? key}) : super(key: key);

  @override
  State<CurrentOrderPage> createState() => _CurrentOrderPageState();
}

class _CurrentOrderPageState extends State<CurrentOrderPage> {
  @override
  Widget build(BuildContext context) {
    final menuProvider = context.read<MenuProvider>();
    final account = context.read<AccountProvider>().account;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Current Order"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          ListView.separated(shrinkWrap: true,
              itemBuilder: (context, index) => FoodItemSummaryTile(menuProvider.currentOrder[index], () {
                setState(() {
                  // To update price live
                });
              }), separatorBuilder: (_, index) => const SizedBox(height: 5,), itemCount: menuProvider.currentOrder.length),
          Spacer(),
          Text("£${account.getCartTotal(menuProvider.menu)}",
          style: const TextStyle(
          fontWeight: FontWeight.bold,
            fontSize: 40,
    )),
          Expanded(child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(onPressed: () {
              account.sendOrder(menuProvider.menu);
            }, child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/cart_icon.png', width: 30,),
                const Text("CONFIRM / SEND TO DATABASE"),
              ],
            )),
          ))
        ],
      ),
    );
  }
}
