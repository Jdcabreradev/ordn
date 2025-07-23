import 'package:go_router/go_router.dart';
import 'package:ordn/views/details_screen.dart';
import 'package:ordn/views/form_screen.dart';
import 'package:ordn/views/home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsScreen(),
    ),
    GoRoute(path: '/form', builder: (context, state) => const FormScreen()),
  ],
);
