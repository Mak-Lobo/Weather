import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../urls/forecast.dart';
import './../urls/location.dart';
import './../locations/location.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationUrls = LocationUrls();
    final forecast = Forecasts();
    final deviceLocation = DeviceLocation();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.amber,
        body: GestureDetector(
          onTap: () {
            locationUrls.getLocationSearch();
            forecast.getDailyForecast();
            deviceLocation.getLocation();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.pin_drop_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.push('/locations');
                          },
                        ),
                      ),
                      const Text(
                        'My Weather',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Cairo, Egypt',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '25°C',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              SliverAnimatedGrid(
                key: GlobalKey<SliverAnimatedGridState>(),
                initialItemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemBuilder:
                    (
                      BuildContext context,
                      int index,
                      Animation<double> animation,
                    ) {
                      return ScaleTransition(
                        scale: animation,
                        child: Card(
                          color: Theme.of(context).colorScheme.secondary,
                          child: const Center(
                            child: Text(
                              'Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
