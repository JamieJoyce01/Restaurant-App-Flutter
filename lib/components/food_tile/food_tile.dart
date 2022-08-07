import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';
import 'package:synoptic_restaurant_app/constants/numbers.dart';
import 'package:synoptic_restaurant_app/main_classes/food_item/food_item.dart';
import 'package:synoptic_restaurant_app/providers/account_provider.dart';

class FoodTile extends StatefulWidget {
  FoodTile(this.foodItem, this.priceCallback);
  final FoodItem foodItem;
  Function priceCallback;

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountProvider>().account;
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: COLOUR_SCHEME_BLUE,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: 110,
            child: Image.asset(widget.foodItem.imageUrl, fit: BoxFit.fitHeight,),
          ),
          Expanded(child: Container(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.foodItem.name, style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),),

              ],
            ),
          )),
          IconButton(onPressed: () {
            // This if prevents a null error if this button was spammed.
            if((account.cart[widget.foodItem.name] ?? 0) == 0) {
              return;
            }
            account.removeFromCart(widget.foodItem.name);
            widget.priceCallback();

          }, icon: Visibility(visible: (account.cart[widget.foodItem.name] ?? 0) == 0 ? false : true,
              child: const ImageIcon(AssetImage("assets/remove_icon.png")))) ,
          Text(((account.cart[widget.foodItem.name]) ?? 0).toString()),
          IconButton(onPressed: () {
            account.addToCart(widget.foodItem.name);
            widget.priceCallback();
          }, icon: Visibility(visible: (account.cart[widget.foodItem.name] ?? 0) == MAX_AMOUNT_PER_ITEM ? false :true,
              child: const ImageIcon(AssetImage("assets/add_icon.png")))),
        ],
      ),
    );
  }
}
