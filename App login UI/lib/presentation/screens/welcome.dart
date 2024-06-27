import 'package:app_login_ui/core/item.dart';
import 'package:app_login_ui/presentation/widget/cookies_button.dart';
import 'package:app_login_ui/presentation/widget/log_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/wikipedia.dart';
import '../../core/router.dart';
import 'article.dart';
import '../widget/error.dart';

class WelcomeScreen extends StatelessWidget {
  final String user;

  WelcomeScreen(this.user, {super.key});

  var articles = getArticleIntros(
    testItems.map(
      (item) => item.wikipediaTitle,
    ),
    sentenceCount: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido $user'),
          actions: [
            const LogOutButton(),
            CookiesButton(),
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
                        print(articles[index]!.title);
                        var testItemsIndex = testItems.indexWhere((item) => item
                            .wikipediaTitle
                            .toLowerCase()
                            .contains(articles[index]!.title.toLowerCase()));
                        return Card(
                          child: ListTile(
                            title: Text(
                              testItems[testItemsIndex].title ??
                                  testItems[testItemsIndex].wikipediaTitle,
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
