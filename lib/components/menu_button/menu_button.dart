import 'package:flutter/material.dart';
import 'package:synoptic_restaurant_app/constants/colours.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key, required this.buttonImage, required this.buttonText, required this.onPressed}) : super(key: key);

  final AssetImage buttonImage;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: COLOUR_SCHEME_WHITE,
                  image: DecorationImage(image: buttonImage,
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 10,
                  child: SizedBox(
                    child: Text(buttonText, style: const TextStyle(color: COLOUR_SCHEME_WHITE, fontSize: 40, shadows: [
                        Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                     ),
                  ]
                    ),
                  ))
              )
            ]
        )
        )
    );
  }
}
