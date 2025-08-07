import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './device_location//location.dart';
import './urls/base.dart';
import './urls/current.dart';
import './urls/daily_forecast.dart';
import './urls/hourly_forecast.dart';
import './urls/location.dart';

import './pages/home.dart';
import './pages/locations.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices(); // Initialize services before setting up functions
  await dotenv.load(fileName: ".env");
  final base = getIt<Base>();
  await base.baseInit(); // Initialize the base configuration
  runApp(const ProviderScope(child: MyApp()));
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
      path: '/device_location',
      builder: (BuildContext context, GoRouterState state) => const Locations(),
    ),
  ],
);

void setupServices() {
  getIt.registerLazySingleton<Base>(() => Base());
  getIt.registerLazySingleton<LocationUrls>(() => LocationUrls());
  getIt.registerLazySingleton<CurrentWeather>(() => CurrentWeather());
  getIt.registerLazySingleton<DailyForecast>(() => DailyForecast());
  getIt.registerLazySingleton<HourlyForecast>(() => HourlyForecast());
  getIt.registerLazySingleton<DeviceLocation>(() => DeviceLocation());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}
