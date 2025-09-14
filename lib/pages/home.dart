import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:weather/custom_widget/custom_container.dart';
import 'package:weather/services.dart';
import '../custom_widget/saved_locations.dart';
import './../custom_widget/custom_card.dart';
import './../custom_widget/icons.dart';

GetIt getIt = GetIt.instance;

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _locationUrlsAsync = ref.watch(locationProvider);
    final _dailyForecastAsync = ref.watch(dailyForecastDataProvider);
    // final _deviceLocationAsync = ref.watch(deviceLocationProvider);
    final _currentWeatherAsync = ref.watch(currentWeatherDataProvider);
    final _hourlyForecastAsync = ref.watch(hourlyForecastDataProvider);
    final _savedLocationsWeatherAsync = ref.watch(
      savedLocationsWeatherProvider,
    );

    // // instances
    // final _locationUrls = getIt<LocationUrls>();
    // final _dailyForecast = getIt<DailyForecast>();
    // final _deviceLocation = getIt<DeviceLocation>();
    // final _currentWeather = getIt<CurrentWeather>();
    // final _hourlyForecast = getIt<HourlyForecast>();

    const String degreeSymbol = '\u00B0';

    return _currentWeatherAsync.when(
      data: (currentWeather) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverAppBar(
                  floating: true,
                  snap: true,
                  title: const Text('Weather'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () => context.push('/device_location'),
                      icon: const Icon(Icons.location_on_sharp),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(dailyForecastDataProvider.notifier).refresh();
                        ref.read(currentWeatherDataProvider.notifier).refresh();
                        ref.read(hourlyForecastDataProvider.notifier).refresh();
                        ref
                            .read(savedLocationsWeatherProvider.notifier)
                            .refresh();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ),

              // main data of interest
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.975,
                      child: CustomCard(
                        bgColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, size: 25),
                                              const SizedBox(width: 10),
                                              Text(
                                                currentWeather?['location'] ??
                                                    'N/A',
                                                // Assuming name is available
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'As of: ${currentWeather?['currentTime'] ?? 'N/A'} ',
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      getIcon(
                                        currentWeather?['weatherIcon'] ?? 0,
                                      ),
                                      size: 75.25,
                                    ),
                                  ),
                                  // const Icon(Icons.wb_sunny, size: 50),
                                  // dynamic icon update function to be placed
                                ],
                              ),
                              const SizedBox(height: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${currentWeather?['temperature'] ?? 'N/A'}$degreeSymbol C',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currentWeather?['weatherText'] ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: const EdgeInsets.all(8.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // saved locations data
              SliverPadding(padding: const EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Saved Locations Weather data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: CustomContainer(child: const WeatherCarousel()),
                ),
              ),

              // 12 Hour Forecast
              SliverPadding(padding: const EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '12 Hour Forecast',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: CustomContainer(
                    child: _hourlyForecastAsync.when(
                      data: (hourlyForecast) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: hourlyForecast.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.all(5),
                            child: CustomCard(
                              bgColor: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(hourlyForecast[index]['time']),
                                  Icon(
                                    getIcon(hourlyForecast[index]['icon']),
                                    size: 30,
                                  ),
                                  Text(
                                    '${hourlyForecast[index]['temperature']}$degreeSymbol C',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      loading: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitPulse(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 56.25,
                          ),
                          Text(
                            'Periodic hourly forecast update...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                    ),
                  ),
                ),
              ),

              // 5 Day Forecast
              SliverPadding(padding: const EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '5-Day Forecast',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: CustomContainer(
                    child: _dailyForecastAsync.when(
                      data: (dailyForecast) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: dailyForecast.length,
                        itemBuilder: (context, index) {
                          final date = dailyForecast.keys.elementAt(index);
                          final data = dailyForecast[date];
                          return Container(
                            margin: const EdgeInsets.all(5),
                            child: CustomCard(
                              bgColor: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                              child: ListTile(
                                title: Text(data['date'] ?? 'N/A'),
                                subtitle: Text(
                                  'Max: ${data['max_temperature'] ?? 'N/A' ?? 'N/A'}$degreeSymbol C, Min: ${data['min_temperature']}$degreeSymbol C',
                                ),
                                leading: SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Icon(
                                        getIcon(data['dayIcon'] ?? 0),
                                        size: 30,
                                      ),
                                      Text(
                                        "Day: ${data['dayIconPhrase'] ?? 'N/A'}",
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Icon(
                                        getIcon(data['nightIcon'] ?? 0),
                                        size: 30,
                                      ),
                                      Text(
                                        "Night: ${data['nightIconPhrase'] ?? 'N/A'}",
                                        style: TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                      loading: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitPulse(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 56.25,
                          ),
                          Text(
                            'Periodic daily forecast update...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: const EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Conditions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 10),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final conditions = {
                        'Feels Like':
                            '${currentWeather?['feelsLike'] ?? 'N/A'}°C',
                        'Humidity': '${currentWeather?['humidity'] ?? 'N/A'}%',
                        'Wind': '${currentWeather?['wind'] ?? 'N/A'} km/h',
                        'Pressure':
                            '${currentWeather?['pressure'] ?? 'N/A'} hPa',
                      };
                      final weatherIcons = [
                        Icons.thermostat,
                        Icons.water_drop,
                        MdiIcons.weatherWindy,
                        Symbols.compress,
                      ];
                      final key = conditions.keys.elementAt(index);
                      final value = conditions[key]!;
                      return CustomCard(
                        bgColor: Theme.of(context).colorScheme.inversePrimary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              weatherIcons[index],
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(value, style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    },
                    childCount: 4, // Fixed to 5 conditions
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2 / 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => Center(
        child: SpinKitFoldingCube(
          size: 75,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Failed to fetch data.',
              style: TextStyle(
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Error: $error',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                decorationStyle: TextDecorationStyle.dashed,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () =>
                  ref.read(dailyForecastDataProvider.notifier).refresh(),
              child: Text('Retry'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
