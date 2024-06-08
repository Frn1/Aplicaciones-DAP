import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/wikipedia.dart';
import '../../core/router.dart';
import 'article.dart';
import '../widget/error.dart';

const articleTitles = [
  "Dart",
  "C++",
  "C (lenguaje de programación)",
  "Rust (lenguaje de programación)",
  "JavaScript",
  "Java (lenguaje de programación)",
  "Lua",
  "Perl",
  "Haskell",
  "Lisp",
  "Brainfuck",
  "Piet (lenguaje de programación)",
  "COBOL",
  "VBScript",
  "BASIC",
  "Lenguaje ensamblador",
  "C Sharp",
  "Python",
  "Swift (lenguaje de programación)",
  "Pascal (lenguaje de programación)"
];

class WelcomeScreen extends StatelessWidget {
  var cookieTouchCounter = 0;

  final String user;

  WelcomeScreen(this.user, {super.key});

  var articles = getArticleIntros(articleTitles, sentenceCount: 2);

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
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: articles.asStream(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    var articles = snapshot.data;
                    if (articles == null) {
                      return Center(
                        child: SimpleError(
                          error: snapshot.error as String,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              articles[index]!.title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            subtitle: articles[index]!.text != null
                                ? Text(
                                    articles[index]!.text!,
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  )
                                : null,
                            onTap: () {
                              router.push(
                                '/articulo/${articles[index]!.title}',
                                extra: user,
                              );
                            },
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ))
        // body: ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) => ListTile(
        //     title: Text("Hola a $index"),
        //   ),
        // ),
        );
  }
}
