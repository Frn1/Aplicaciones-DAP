import 'package:app_login_ui/core/router.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  var cookieTouchCounter = 0;

  final String user;

  WelcomeScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: const Text('Confirmación'),
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0,
                      ),
                      child: Center(
                        child: Text(
                          '¿Estás seguro que quieres cerrar sesión?',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            router.go("/login");
                          },
                          child: Text(
                            "Sí",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: "Log out",
          ),
          IconButton(
            onPressed: () {
              cookieTouchCounter++;
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
              }
            },
            icon: const Icon(Icons.cookie),
            tooltip: "Mmmmm que rico",
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Hola $user',
            style: const TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
