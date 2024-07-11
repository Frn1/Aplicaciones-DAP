import 'package:app_login_ui/presentation/screens/login.dart';
import 'package:app_login_ui/presentation/screens/welcome.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/article.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(state.extra as String),
    ),
    GoRoute(
      path: '/articulo/:title',
      builder: (context, state) =>
          ArticleScreen(state.pathParameters["title"]!),
    ),
  ],
  initialLocation: '/login',
  redirect: (context, state) {
    if (state.path != '/login') {
      if (state.extra == null) {
        return "/login";
      }
    }
    return state.path;
  },
);
