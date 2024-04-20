// ignore_for_file: use_build_context_synchronously

import 'package:clima_wehather/screens/location_screen.dart';
import 'package:clima_wehather/services/weather.dart';
import 'package:flutter/material.dart';

void getLocationData(BuildContext context, String passedUnit) async {
  var weatherLocation = await WeatherModel().getLocationWeather(passedUnit);
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => LocationScreen(
              locationWeather: weatherLocation,
            )),
  );
}

// Testing git push . . . . . 
