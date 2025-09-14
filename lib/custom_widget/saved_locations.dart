import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather/custom_widget/carousel_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services.dart';

class WeatherCarousel extends ConsumerWidget {
  const WeatherCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataAsync = ref.watch(savedLocationsWeatherProvider);

    return weatherDataAsync.when(
      data: (weatherData) {
        if (weatherData.isEmpty) {
          return Center(
            child: Column(
              children: [
                SpinKitCubeGrid(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                Text(
                  'No saved locations found',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 2750.0,
            autoPlay: false,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            enableInfiniteScroll: weatherData.length > 1,
          ),
          items: weatherData.map((weather) {
            return Builder(
              builder: (BuildContext context) {
                return CarouselCard(
                  location: weather['location'] ?? 'Unknown',
                  weatherText: weather['weatherText'] ?? 'N/A',
                  icon: weather['weatherIcon'] ?? 1,
                  temp: (weather['temperature'] ?? 0.0).toDouble(),
                  feelsLike: (weather['feelsLike'] ?? 0.0).toDouble(),
                );
              },
            );
          }).toList(),
        );
      },
      loading: () => Center(
        child: Column(
          children: [
            SpinKitCubeGrid(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
        ),
      ),
      error: (error, stack) =>
          Center(child: Text('Error loading saved locations: $error')),
    );
  }
}
