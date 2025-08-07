import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:get_it/get_it.dart';
import './urls/current.dart';
import './urls/daily_forecast.dart';
import './urls/hourly_forecast.dart';
import './urls/location.dart';
import './device_location/location.dart';

final getIt = GetIt.instance;

// current weather provider
final currentWeatherDataProvider =
    StateNotifierProvider<
      PeriodicNotifier<Map<String, dynamic>?>,
      AsyncValue<Map<String, dynamic>?>
    >(
      (ref) => PeriodicNotifier(
        () => getIt<CurrentWeather>().getCurrentLocationWeather(),
        interval: const Duration(minutes: 15),
      ),
    );

// hourly forecast provider
final hourlyForecastDataProvider =
    StateNotifierProvider<
      PeriodicNotifier<List<dynamic>>,
      AsyncValue<List<dynamic>>
    >(
      (ref) => PeriodicNotifier(
        () => getIt<HourlyForecast>().getHourlyForecastData(),
        interval: const Duration(minutes: 30),
      ),
    );

final dailyForecastDataProvider =
    StateNotifierProvider<
      PeriodicNotifier<Map<String, dynamic>>,
      AsyncValue<Map<String, dynamic>>
    >(
      (ref) => PeriodicNotifier(
        () => getIt<DailyForecast>().getDailyForecastData(),
        interval: const Duration(hours: 1),
      ),
    );

// final locationProvider = StateNotifierProvider(
//   (ref) => PeriodicNotifier(() => getIt<LocationUrls>().getLocationSearch()),
// );
// location provider
final locationProvider = Provider<LocationUrls>((ref) => getIt<LocationUrls>());

// search query provider
final searchProvider = StateProvider<String>((ref) => '');

// results provider
final resultsProvider = FutureProvider<List<dynamic>?>((ref) async {
  final searchQuery = ref.watch(searchProvider);
  if (searchQuery.isEmpty) {
    return [];
  }
  final locationDetails = ref.watch(locationProvider);
  return await locationDetails.getLocationSearch(location: searchQuery) ?? [];
});

// device location provider
final deviceLocationProvider =
    StateNotifierProvider<
      PeriodicNotifier<Map<String, dynamic>>,
      AsyncValue<Map<String, dynamic>>
    >(
      (ref) => PeriodicNotifier(
        () => getIt<DeviceLocation>().getLocation(),
        interval: const Duration(minutes: 15),
      ),
    );

// current weather provider generic class
class PeriodicNotifier<T> extends StateNotifier<AsyncValue<T>> {
  Timer? _timer;
  final Future<T> Function() fetcher;

  PeriodicNotifier(
    this.fetcher, {
    Duration interval = const Duration(minutes: 5),
  }) : super(const AsyncValue.loading()) {
    _fetchData();
    _startPeriodicFetch(interval);
  }

  Future<void> _fetchData() async {
    state = const AsyncValue.loading();
    try {
      final data = await fetcher();
      state = AsyncValue.data(data);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _startPeriodicFetch(Duration interval) {
    _timer = Timer.periodic(interval, (timer) {
      _fetchData();
    });
  }

  void refresh() => _fetchData();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
