import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '/presentation/dialogs/delete.dart';
import '/presentation/pages/dialog.dart';
import '/presentation/screens/list.dart';
import '/presentation/dialogs/edit.dart';
import '/presentation/dialogs/new.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: "Lista",
    builder: (context, state) => const ListScreen(),
  ),
  GoRoute(
    path: "/edit/:index",
    pageBuilder: (BuildContext context, GoRouterState state) {
      return DialogPage(
        builder: (_) => EditElementDialog(
          elementIndex: int.parse(
            state.pathParameters["index"]!,
          ),
        ),
      );
    },
  ),
  GoRoute(
    path: "/new/:index",
    pageBuilder: (BuildContext context, GoRouterState state) {
      return DialogPage(
        builder: (_) => NewElementDialog(
          elementIndex: int.parse(
            state.pathParameters["index"]!,
          ),
        ),
      );
    },
  ),
  GoRoute(
    path: "/delete/:index",
    pageBuilder: (BuildContext context, GoRouterState state) {
      return DialogPage(
        builder: (_) => DeleteElementDialog(
          elementIndex: int.parse(
            state.pathParameters["index"]!,
          ),
        ),
      );
    },
  ),
]);
