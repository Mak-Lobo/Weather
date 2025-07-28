import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../urls/dailyForecast.dart';
import './../urls/location.dart';
import './../locations/location.dart';
import './../urls/current.dart';
import './../urls/hourlyForecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocationUrls _locationUrls = LocationUrls();
  final DailyForecast _forecast = DailyForecast();
  final DeviceLocation _deviceLocation = DeviceLocation();
  final CurrentWeather _currentWeather = CurrentWeather();
  final HourlyForecast _hourlyForecast = HourlyForecast();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.amber,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: const Text('Weather'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => context.push('/locations'),
                  icon: const Icon(Icons.location_on_sharp),
                ),
              ],
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.975,
                    child: Card(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderOnForeground: true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.location_on),
                                      ),
                                      Text(
                                        'Washington DC',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Text('Monday, 18 Dec'),
                                ],
                              ),
                              const Icon(Icons.sunny, size: 50),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '22°',
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sunny',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: const [Text('18°'), Text('min')],
                                  ),
                                  Icon(Icons.arrow_upward_sharp),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: const [Text('26°'), Text('max')],
                                  ),
                                  Icon(Icons.arrow_downward),
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.all(8.0)),
                        ],
                      ),
                    ),
                  ),
                ],
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  height: 150, // Adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12, // For 12 hour forecast
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 100, // Adjust width as needed for each item
                        child: Card(
                          color: Theme.of(context).colorScheme.onSecondary,
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${index + 1}:00'), // Example time
                              Icon(
                                Icons.wb_cloudy, // Example icon
                                size: 30,
                              ),
                              Text('20°'), // Example temperature
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // 5 hr forecast
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
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150, // Adjust width as needed for ListTile
                        child: Card(
                          color: Theme.of(context).colorScheme.onSecondary,
                          margin: const EdgeInsets.all(8.0),
                          child: const ListTile(
                            leading: Icon(
                              Icons.sunny,
                              size: 40,
                            ), // Adjust size as needed
                            title: Text('Monday'),
                            subtitle: Text('22°'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // current conditions
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: AnimationLimiter(
                child: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5, // Adjust aspect ratio as needed
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // Example data - replace with actual weather data
                      final conditions = [
                        {
                          'icon': Icons.thermostat,
                          'label': 'Feels Like',
                          'value': '25°C',
                        },
                        {
                          'icon': Icons.water_drop,
                          'label': 'Humidity',
                          'value': '60%',
                        },
                        {
                          'icon': Icons.air,
                          'label': 'Wind',
                          'value': '10 km/h',
                        },
                        {
                          'icon': Icons.visibility,
                          'label': 'Visibility',
                          'value': '10 km',
                        },
                        {
                          'icon': Icons.arrow_downward,
                          'label': 'Pressure',
                          'value': '1012 hPa',
                        },
                        {
                          'icon': Icons.wb_sunny,
                          'label': 'UV Index',
                          'value': 'High',
                        },
                      ];

                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Card(
                              color: Theme.of(context).colorScheme.onSecondary,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      conditions[index]['icon'] as IconData,
                                      size: 30,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondaryContainer,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      conditions[index]['label'] as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      conditions[index]['value'] as String,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondaryContainer,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: 6, // Number of items in the grid
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
