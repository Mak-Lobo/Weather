class Weather{
  final String location;
  final String temperature;
  final String condition;
  final String iconUrl;
  String? humidity;
  String? windSpeed;
  String? pressure;
  String? visibility;

  Weather({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    this.humidity,
    this.windSpeed,
    this.pressure,
    this.visibility,
  });

  // object to Json
  Map<String, dynamic> toMapWeather() {
    return {
      'location': location,
      'temperature': temperature,
      'condition': condition,
      'iconUrl': iconUrl,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'pressure': pressure,
      'visibility': visibility,
    };
  }

  // Json to object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: json['location'],
      temperature: json['temperature'],
      condition: json['condition'],
      iconUrl: json['iconUrl'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
      pressure: json['pressure'],
      visibility: json['visibility'],
    );
  }
}