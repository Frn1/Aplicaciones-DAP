import 'package:flutter/material.dart';

class SimpleError extends StatelessWidget {
  final String error;

  final Axis axis;

  const SimpleError(
      {this.error = "Ups! Ocurrió un error",
      this.axis = Axis.vertical,
      super.key});

  @override
  Widget build(BuildContext context) {
    var widgets = [
        const Icon(Icons.warning_rounded),
        Text(
          error,
          textAlign: TextAlign.center,
        ),
      ];
    return axis == Axis.vertical ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}
