import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../core/wikipedia.dart';
import '../widget/error.dart';

class ArticleScreen extends StatelessWidget {
  final String title;
  const ArticleScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    var articles = getFullarticle(title).asStream().asBroadcastStream();

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: articles,
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
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: articles,
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
                    child: HtmlWidget(
                      "${snapshot.data?.html}",
                      renderMode: RenderMode.listView,
                      baseUrl: Uri.parse("https://es.wikipedia.org"),
                      onTapImage: (p0) {},
                      onTapUrl: null,
                      onErrorBuilder: (context, element, error) {
                        return SimpleError(error: error);
                      },
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
