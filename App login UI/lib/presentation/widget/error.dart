import 'package:flutter/material.dart';

class SimpleError extends StatelessWidget {
  final String error;

  const SimpleError({this.error = "Ups! Ocurrió un error", super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.warning_rounded),
        Text(
          error,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
