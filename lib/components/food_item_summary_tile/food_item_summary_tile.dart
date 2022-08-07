import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item_summary.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';

class FoodItemSummaryTile extends StatefulWidget {
  const FoodItemSummaryTile(this.foodSummaryItem, this.callback);
  final FoodItemSummary foodSummaryItem;
  final Function callback;

  @override
  State<FoodItemSummaryTile> createState() => _FooditemSummaryTileState();
}

class _FooditemSummaryTileState extends State<FoodItemSummaryTile> {
  TextStyle testStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18
  );

  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountProvider>().account;
    return Visibility(
      // If removed from cart/0 then effectively delete as far as the user is concerned.
      visible: account.cart[widget.foodSummaryItem.foodItemName] == null ? false : true,

      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: COLOUR_SCHEME_BLUE,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(left: 20,
              child: Text(widget.foodSummaryItem.foodItemName, style: testStyle),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {
                  setState(() {
                    account.removeFromCart(widget.foodSummaryItem.foodItemName);
                  });
                  widget.callback();
                }, icon: const ImageIcon(AssetImage("assets/remove_icon.png"))),
                Text(account.cart[widget.foodSummaryItem.foodItemName].toString(), style: testStyle),
                IconButton(onPressed: () {
                  setState(() {
                    account.addToCart(widget.foodSummaryItem.foodItemName);
                  });
                  widget.callback();
                }, icon: const ImageIcon(AssetImage("assets/add_icon.png"))),

              ],
            ),
            Positioned(right: 20,
              child: Text("£${(widget.foodSummaryItem.foodItemPrice*(account.cart[widget.foodSummaryItem.foodItemName] ?? 0)).toStringAsFixed(2)}", style: testStyle),),

            const SizedBox(width: 20),
          ],
        ),
      ),
    );


  }
}
