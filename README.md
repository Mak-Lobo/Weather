<!-- ![Weather](./assets/weather.png)  -->
<img src = "./assets/weather.png" alt = "Weather" width = 300 style = "display: block; margin-left: auto; margin-right: auto;">

# Weather 2.0

This is a project similar to the original Weather app (click
this **[link](https://github.com/Mak-Lobo/weather-flutter)** to see the original) but with a simpler,
intuitive and more modern UI.

The project achieves it purpose through the following:

- **[AccuWeather](https://developer.accuweather.com/)** API to fetch weather data,
  currently using the free trial until 23rd of September, 2025.
- **[Sqflite](https://pub.dev/packages/sqflite)** to store the saved locations of interest.

- **[Riverpod](https://pub.dev/packages/riverpod)** for state management.

- **[Dio](https://pub.dev/packages/dio)** for HTTP requests.

- **[Location](https://pub.dev/packages/location)** for geolocation.

- **[SpinKit](https://pub.dev/packages/spinkit)** for loading indicators.

- **[GoRouter](https://pub.dev/packages/go_router)** for navigation.

***App preview***
------------------------------

1. **Home**
______

| Dark theme Portrait                                        | Light Theme Portrait                                         |
|------------------------------------------------------------|--------------------------------------------------------------|
| ![Home Dark Portrait](./assets/pics/Home_Potrait_Dark.png) | ![Home Light Portrait](./assets/pics/Home_Potrait_Light.png) |
___
| Dark theme Landscape                                          | Light Theme Landscape                                           |
|---------------------------------------------------------------|-----------------------------------------------------------------|
| ![Home Dark Landscape](./assets/pics/Home_Landscape_Dark.png) | ![Home Light Landscape](./assets/pics/Home_Landscape_Light.png) |



2. **Locations**

| Dark theme Portrait                                                | Light Theme Portrait                                                 |
|--------------------------------------------------------------------|----------------------------------------------------------------------|
| ![Locations Dark Portrait](./assets/pics/Location_Search_Dark.png) | ![Locations Light Portrait](./assets/pics/Location_Search_Light.png) |

3. **Saved Locations**

| Dark theme Portrait                                                    | Light Theme Portrait                                                     |
|------------------------------------------------------------------------|--------------------------------------------------------------------------|
| ![Saved Locations Dark Portrait](./assets/pics/Location_Save_Dark.png) | ![Saved Locations Light Portrait](./assets/pics/Location_Save_Light.png) |

___

### Configuration

The project has the AccuWeather API key and base URL stored in the `.env` file. Create the file in the parent directory with
the structure below:

```
API_Key = <API_KEY>
BaseURL = <BASE_URL>
```
**Note:** Obtain a valid API key from [AccuWeather](https://developer.accuweather.com/).

### Installation
- Clone the repository
- Configure as described above
- Run `flutter pub get`
- Run `flutter run`
