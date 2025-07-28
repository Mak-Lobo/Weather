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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: Colors.blueGrey[400],
          foregroundColor: Colors.white,
          shadowColor: Colors.blue[700],
          elevation: 20,
          scrolledUnderElevation: 30,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          foregroundColor: Colors.white,
          shadowColor: Colors.blue[300],
          elevation: 20,
          scrolledUnderElevation: 30,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}
