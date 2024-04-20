import 'package:clima_wehather/services/networking.dart';
import 'package:clima_wehather/services/location.dart';
import 'package:clima_wehather/functions/statics.dart';

class WeatherModel {
  static String apiKey = Statics.weatherApiKey;
  static String weatherApiKey = apiKey;
  static const urlString = "https://api.openweathermap.org/data/2.5/weather";

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        "$urlString?q=${cityName}&appid=$weatherApiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather(String unit) async {
    Location location = Location();
    await location.getCurrentLocationFunction();

    NetworkHelper networkHelper = NetworkHelper(
        "$urlString?lat=${location.latitude}&lon=${location.longitude}&appid=$weatherApiKey&units=$unit");
    print(
        "$urlString?lat=${location.latitude}&lon=${location.longitude}&appid=$weatherApiKey&units=$unit");
    var weatherData = await networkHelper.getData();
    // ignore: use_build_context_synchronously

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String getBackgroundImage(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWindDirection(dynamic degrees, dynamic speed) {
    if (speed == 0) {
      return 'No Wind detected';
    } else {
      const directions = [
        'North',
        'North-Northeast',
        'Northeast',
        'East-Northeast',
        'East',
        'East-Southeast',
        'Southeast',
        'South-Southeast',
        'South',
        'South-Southwest',
        'Southwest',
        'West-Southwest',
        'West',
        'West-Northwest',
        'Northwest',
        'North-Northwest',
        'North'
      ];
      degrees %= 360;
      final index = ((degrees + 11.25) % 360 / 22.5).round();
      return directions[index];
    }
  }
}

// 