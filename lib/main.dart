import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

import './urls/base.dart';
import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/locations.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final base = Base();
  await base.baseInit(); // Initialize the base configuration
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/locations',
      builder: (BuildContext context, GoRouterState state) => const Locations(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 41, 59),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[600],
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 41, 59),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[600],
          foregroundColor: Colors.white,
        ),
        brightness: Brightness.dark,
      ),
      routerConfig: _router,
    );
  }
}
