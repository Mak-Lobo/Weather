import 'package:flutter/material.dart';
import 'package:weather/custom_widget/icons.dart';

class CarouselCard extends StatelessWidget {
  final String location;
  final String weatherText;
  final int icon;
  final double temp;
  final double feelsLike;

  const CarouselCard({
    super.key,
    required this.location,
    required this.weatherText,
    required this.icon,
    required this.temp,
    required this.feelsLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        shadowColor: Colors.black,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              location,
              style: Theme.of(context).textTheme.displayMedium,
              overflow: TextOverflow.clip,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  weatherText,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.clip,
                ),
                Icon(getIcon(icon), size: 60),
                Text(
                  '${temp.toStringAsFixed(1)}°C',
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Feels like ${feelsLike.toStringAsFixed(1)}°C",
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
