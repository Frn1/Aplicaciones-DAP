import 'package:app_login_ui/core/item.dart';
import 'package:app_login_ui/presentation/widget/cookies_button.dart';
import 'package:app_login_ui/presentation/widget/log_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/wikipedia.dart';
import '../../core/router.dart';
import '../widget/error.dart';

class WelcomeScreen extends StatelessWidget {
  final String user;

  const WelcomeScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido $user'),
          actions: const [
            LogOutButton(),
            CookiesButton(),
          ],
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StreamBuilder(
              stream: getArticleIntros(
                testItems.map(
                  (item) => item.wikipediaTitle,
                ),
                sentenceCount: 2,
              ).asStream(),
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
                        var testItemsIndex = testItems.indexWhere((item) => item
                            .wikipediaTitle
                            .toLowerCase()
                            .contains(articles[index]!.title.toLowerCase()));
                        return Card(
                          child: ListTile(
                            leading: testItemsIndex != -1 &&
                                    testItems[testItemsIndex].imageUrl != null
                                ? AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      testItems[testItemsIndex]
                                          .imageUrl!
                                          .toString(),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : null,
                            title: Text(
                              testItemsIndex != -1
                                  ? testItems[testItemsIndex].title ??
                                      testItems[testItemsIndex].wikipediaTitle
                                  : articles[index]!.title,
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
