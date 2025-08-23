import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_card.dart';
import '../database.dart';

class LocationCard extends StatelessWidget {
  final Color bgColor;
  final String locale, country, state, localKey;
  final VoidCallback? deleteLocation;

  const LocationCard({
    super.key,
    required this.bgColor,
    required this.locale,
    required this.country,
    required this.state,
    required this.localKey,
    this.deleteLocation,
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
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => dialogSaveLocation(context),
          );
        },
        onLongPress: deleteLocation,
      ),
    );
  }

  // dialog box for location to be saved
  Widget dialogSaveLocation(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.saved_search_rounded),
      title: Text('Save Location'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Do you wish to save the following location?'),
          ListTile(title: Text(locale), subtitle: Text('$state, $country')),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      actions: [
        ElevatedButton(
          onPressed: context.pop,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            try {
              saveLocation(locale, state, country, localKey);
              context.pop();
            } catch (_) {
              showAboutDialog(
                context: context,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  Center(child: Text('Error in saving location')),
                ],
                barrierDismissible: true,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text('Save'),
        ),
      ],
    );
  }
}

// saved location card
class SavedLocation extends StatelessWidget {
  final Color bgColor;
  final String cityName, adminState, country;
  final VoidCallback deleteLocation;

  const SavedLocation({
    super.key,
    required this.bgColor,
    required this.cityName,
    required this.adminState,
    required this.country,
    required this.deleteLocation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      bgColor: bgColor,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: Icon(Icons.location_on),
        title: Text(cityName),
        subtitle: Text('$adminState, $country'),
        onLongPress: deleteLocation,
      ),
    );
  }
}
