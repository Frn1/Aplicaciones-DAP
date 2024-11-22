// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import '/dialogs/delete.dart';
import '/dialogs/edit.dart';
import '/dialogs/new.dart';
import '/pages/dialog.dart';
import '/providers/user.dart';
import 'screens/shopping_list.dart';
import '/screens/login.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "Menú principal",
      builder: (context, state) => const GroceryListScreen(),
      routes: [
        GoRoute(
          path: "edit/:index",
          name: "Editar",
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
          path: "new",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return DialogPage(
              builder: (_) => NewElementDialog(),
            );
          },
        ),
        GoRoute(
          path: "delete/:index",
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
    ),
    GoRoute(
      path: '/login',
      name: "Login",
      builder: (context, state) => LoginScreen(),
    ),
  ],
  redirect: (context, state) {
    if (user == null) {
      return '/login';
    }
    return null;
  },
);
