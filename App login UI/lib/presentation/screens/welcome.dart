import 'package:app_login_ui/core/router.dart';
import 'package:flutter/material.dart';

import '../../core/wikipedia.dart';

class WelcomeScreen extends StatelessWidget {
  var cookieTouchCounter = 0;

  final String user;

  WelcomeScreen(this.user, {super.key});

  var articles = getArticles(["Tennis"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido $user'),
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
                                color: Colors.green[600],
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
        body: StreamBuilder(
          stream: articles.asStream(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == null) {
                  return const Center(
                    child: Icon(Icons.warning_rounded),
                  );
                }
                return Text(snapshot.data!.$2);
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        )
        // body: ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) => ListTile(
        //     title: Text("Hola a $index"),
        //   ),
        // ),
        );
  }
}
