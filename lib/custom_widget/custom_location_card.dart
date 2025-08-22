import 'package:flutter/material.dart';
import 'custom_card.dart';

class LocationCard extends StatelessWidget {
  final Color bgColor;
  final String locale, country, state;

  const LocationCard({
    super.key,
    required this.bgColor,
    required this.locale,
    required this.country,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      bgColor: bgColor,
      isBorderShown: true,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        title: Text(locale, style: Theme.of(context).textTheme.displaySmall),
        subtitle: Text(
          "$state, $country",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
