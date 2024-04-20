import 'package:clima_wehather/screens/city_screen.dart';
import 'package:clima_wehather/services/weather.dart';
import 'package:clima_wehather/widgets/FanWidget.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temprature;
  int? condition;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;
  double? long;
  double? lat;
  String? weatherDescription;
  int? realFeel;
  int? highestTep;
  int? lowestTemp;
  double? windDegree;
  int? windSpeed;
  String? networkImage;
  String? unit;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        print("data is empty ");
        temprature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = "";
        double temp = 0.0;
        temprature = temp.toInt();
        var condition = 0;
        weatherIcon = "No data available";
        weatherMessage = "No data available";
        networkImage = "No data available";
        long = 0.0;
        lat = 0.0;
        weatherDescription = "No data available";
        realFeel = 0;
        highestTep = 0;
        lowestTemp = 0;
        windSpeed = 0;
        windDegree = 0.0;
        unit = "";
        return;
      } else {
        print('Not Empty');
        print(weatherData['main']['temp']);
        double temp = weatherData['main']['temp'].toDouble();
        temprature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(temprature!);
        networkImage = weather.getBackgroundImage(condition);
        cityName = weatherData['name'];
        long = weatherData['coord']['lon'];
        lat = weatherData['coord']['lat'];
        weatherDescription = weatherData['weather'][0]["main"];
        realFeel = weatherData["main"]["feels_like"].toInt();
        highestTep = weatherData["main"]["temp_max"].toInt();
        lowestTemp = weatherData["main"]["temp_min"].toInt();
        windSpeed = weatherData["wind"]["speed"].toInt();
        windDegree = weatherData["wind"]["deg"].toDouble();
        unit = 'metric';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather(unit!);
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.location_pin,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var searchedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (searchedCity != null) {
                        var weatherData =
                            await weather.getCityWeather(searchedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text('Current Location : ' + cityName!),
              InkWell(
                onTap: () async {
                  // Fluttertoast.showToast(
                  //     msg: "Show on google maps will be added later");
                },
                child: Column(
                  children: [
                    Text(long.toString()),
                    Text(lat.toString()),
                  ],
                ),
              ),
            ]),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 25.0, left: 25.0, top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '°$temprature',
                        style: const TextStyle(
                          fontSize: 55,
                        ),
                      ),
                      Text(
                        weatherIcon!,
                        style: const TextStyle(
                          fontSize: 55,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var weatherData =
                              await weather.getLocationWeather("metric");
                          updateUI(weatherData);
                        },
                        child: const Text("°C"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var weatherData =
                              await weather.getLocationWeather("imperial");
                          updateUI(weatherData);
                        },
                        child: const Text("°F"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "H-" + '${highestTep!.ceil().toString()}°',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "L-" + '${lowestTemp!.ceil().toString()}°',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Feels Like " + '${realFeel!.ceil().toString()}°',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text("Wind Speed:  $windSpeed (km/h)"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: FanIconWidget(
                                  windSpeed: int.parse(windSpeed.toString())),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Wind Direction: ',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(weather.getWindDirection(
                                windDegree, windSpeed)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//  Text(
//                 weatherMessage,
//                 textAlign: TextAlign.right,
//                 style: kMessageTextStyle,
//               ),

