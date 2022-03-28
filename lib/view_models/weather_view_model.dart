import 'package:flutter/material.dart';

import '../model/weather_data.dart';
import '../services/fake_data.dart';
import '../services/weatherlink_data.dart';

class WeatherViewModel extends ChangeNotifier {
  late WeatherData _weatherData;

  bool isLoading = true;

  IconData get icon {
    return Icons.wb_sunny_outlined;
  }

  int get currentTemp {
    return _weatherData.temperature;
  }

  int get feelsLike {
    return _weatherData.feelsLikeTemperature;
  }

  String get windDirection {
    final dir = _weatherData.windDirection;

    // TODO add logic to convert the direction to N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW, WSW, W, WNW, NW, NNW
    if(dir > 348.75 && dir <= 11.25) {
      return 'N';
    } else if (dir > 11.25 && dir <= 33.75) {
      return 'NNE';
    } else if (dir > 33.75 && dir <= 56.25) {
      return 'NE';
    } else if (dir > 56.25 && dir <= 78.75) {
      return 'ENE';
    } else if (dir > 78.75 && dir <= 101.25) {
      return 'E';
    } else if (dir > 101.25 && dir <= 123.75) {
      return 'ESE';
    } else if (dir > 123.75 && dir <= 146.25) {
      return 'SE';
    } else if (dir > 146.25 && dir <= 168.75) {
      return 'SSE';
    } else if (dir > 168.75 && dir <= 191.25) {
      return 'S';
    } else if (dir > 191.25 && dir <= 213.75) {
      return 'SSW';
    } else if (dir > 213.75 && dir <= 236.25) {
      return 'SW';
    } else if (dir > 236.25 && dir <= 258.75) {
      return 'WSW';
    } else if (dir > 258.75 && dir <= 281.25) {
      return 'W';
    } else if (dir > 281.25 && dir <= 303.75) {
      return 'WNW';
    } else if (dir > 303.75 && dir <= 326.25) {
      return 'NW';
    } else {
      return 'NNW';
    }

  }

  int get windSpeed {
    return _weatherData.windSpeed;
  }

  int get humidity {
    return _weatherData.humidity.round();
  }

  DateTime get lastUpdated {
    return _weatherData.lastUpdated;
  }

  WeatherViewModel() {
    refresh();
  }

  Future<void> refresh() async {
    isLoading = true;
    notifyListeners();

    //_weatherData = await FakeData().getWeather();
    _weatherData = await WeatherlinkData().getWeather();

    isLoading = false;
    notifyListeners();
  }
}
