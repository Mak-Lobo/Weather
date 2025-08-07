import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

IconData getIcon(int iconCode) {
  switch (iconCode) {
    case 1: // Sunny and Mostly Sunny
    case 2:
      return Icons.wb_sunny;
    case 3:
    case 4 || 21:
      return Symbols.partly_cloudy_day; // Intermittent Clouds and Partly cloudy
    case 5:
      return MdiIcons.weatherHazy; // Hazy Sunshine
    case 6 || 7 || 20: // Mostly Cloudy and Cloudy
      return Icons.cloud;
    case 19:
      return Icons.cloud_queue;
    case 11: // Fog
      return Icons.foggy;
    case 12: // Showers
    case 13: // Mostly Cloudy w/ Showers
    case 14: // Partly Sunny w/ Showers
      return LucideIcons.cloudDrizzle;
    case 15: // Thunderstorms
    case 16: // Mostly Cloudy w/ Thunderstorms
    case 17: // Partly Sunny w/ Thunderstorms
      return Icons.thunderstorm;
    case 18: // Rain
      return Symbols.rainy;
    case 22: // Snow
    case 23 || 44: // Mostly Cloudy w/ Snow
      return Icons.cloudy_snowing;
    case 24: // Ice
      return Icons.ac_unit;
    case 25: // Sleet
      return Icons.ac_unit;
    case 26: // Freezing Rain
      return Symbols.rainy_snow;
    case 29: // Rain and Snow
      return MdiIcons.weatherSnowyRainy;
    case 30: // Hot
      return LucideIcons.flame;
    case 31: // Cold
      return Icons.ac_unit;
    case 32: // Windy
      return Icons.air;
    case 33: // Clear (Night)
    case 34: // Mostly Clear (Night)
      return Icons.nightlight_round;
    case 35: // Partly Cloudy (Night)
    case 36: // Intermittent Clouds (Night)
    case 37: // Hazy Moonlight (Night)
    case 38: // Mostly Cloudy (Night)
      return Symbols.partly_cloudy_night;
    case 39: // Partly Cloudy w/ Showers (Night)
    case 40: // Mostly Cloudy w/ Showers (Night)
      return LucideIcons.cloudDrizzle;
    case 41 || 42 || 43: // clouds/flurries with thunderstorms
      return Icons.thunderstorm;
    default:
      return Icons.cloud;
  }
}
