import 'dart:math';

import 'package:flutter/material.dart';

class CookiesButton extends StatefulWidget {
  const CookiesButton({super.key});

  @override
  State<CookiesButton> createState() => _CookiesButtonState();
}

class _CookiesButtonState extends State<CookiesButton> {
  var cookieTouchCounter = 0;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          cookieTouchCounter++;
        });
        if (cookieTouchCounter > 10) {
          showDialog(
            context: context,
            builder: (context) => const SimpleDialog(
              children: [
                Icon(Icons.cookie),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Mmmmm galletitas... que ricas...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
          setState(() {
            cookieTouchCounter = 0;
          });
        }
      },
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // transform: Matrix4.translation(Vector3 ).scaled(log(cookieTouchCounter / 10 + 1) / log(10) + 1,),
        child: Icon(
          Icons.cookie,
          size: 24,
        ),
      ),
      tooltip: "Mmmmm que rico",
    );
  }
}
