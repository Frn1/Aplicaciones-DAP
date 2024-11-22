// Flutter imports:
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(children: [
        CircularProgressIndicator(
          strokeWidth: 8.0,
          color: Colors.white,
        ),
        CircularProgressIndicator(),
      ]),
    );
  }
}
