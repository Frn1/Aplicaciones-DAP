import 'package:app_login_ui/core/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Login y Listas',
      theme: ThemeData(
        colorSchemeSeed: Colors.orange,
        brightness: MediaQuery.of(context).platformBrightness,
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
