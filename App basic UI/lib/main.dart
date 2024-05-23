import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Log in'),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          size: 30,
                        ),
                        hintText: "Username",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.password,
                          size: 30,
                        ),
                        hintText: "Password",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
