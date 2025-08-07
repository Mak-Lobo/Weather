import 'package:flutter/material.dart';
import 'custom_card.dart';

class LocationCard extends StatelessWidget {
  final Color bgColor;
  final String locale, country;

  const LocationCard({
    super.key,
    required this.bgColor,
    required this.locale,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      bgColor: bgColor.withAlpha(20),
      isBorderShown: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.add_location_alt_sharp, size: 45),
              Text(locale, style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
          Text(country, style: Theme.of(context).textTheme.displaySmall),
        ],
      ),
    );
  }
}
