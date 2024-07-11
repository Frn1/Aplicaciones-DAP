import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/wikipedia.dart';
import '../widget/error.dart';

class ArticleScreen extends StatelessWidget {
  final String title;
  const ArticleScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    var articles = getFullarticle(title);
    var articlesBroadcast = articles.asStream().asBroadcastStream();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: articlesBroadcast,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Text(snapshot.data?.title ?? "¡Whoops!");
              default:
                return const Text('Cargando...');
            }
          },
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder(
            stream: articlesBroadcast,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data == null) {
                    return Center(
                      child: SimpleError(
                        error: snapshot.error as String,
                      ),
                    );
                  }
                  return SizedBox.expand(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: HtmlWidget(
                          "${snapshot.data?.html}",
                          renderMode: RenderMode.column,
                          baseUrl: Uri.parse("https://es.wikipedia.org"),
                          onTapImage: (p0) {},
                          onTapUrl: null,
                          onErrorBuilder: (context, element, error) {
                            return SimpleError(error: error);
                          },
                          customStylesBuilder: (element) {
                            switch (element.localName) {
                              case "tr":
                                final color = Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer;
                                return {
                                  "background-color": "transparent",
                                };
                              case "pre":
                              case "code":
                                return {
                                  "font-family": "Courier, monospace",
                                };
                            }
                          },
                          onLoadingBuilder:
                              (context, element, loadingProgress) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress,
                              ),
                            );
                          },
                          enableCaching: true,
                        ),
                      ),
                    ),
                  );
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
