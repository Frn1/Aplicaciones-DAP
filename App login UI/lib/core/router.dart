import 'package:app_login_ui/presentation/screens/login.dart';
import 'package:app_login_ui/presentation/screens/welcome.dart';
import 'package:go_router/go_router.dart';

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
  ],
  initialLocation: '/login',
);
