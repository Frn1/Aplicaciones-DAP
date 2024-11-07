import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/dialogs/delete.dart';
import '/dialogs/edit.dart';
import '/dialogs/new.dart';
import '/screens/login.dart';
import '/screens/list.dart';
import '/pages/dialog.dart';
import '/providers/user.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "Lista",
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
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
  ],
  redirect: (context, state) {
    final user = ProviderScope.containerOf(context).read(userProvider);
    if (user == null) {
      return '/login';
    }
  },
);
