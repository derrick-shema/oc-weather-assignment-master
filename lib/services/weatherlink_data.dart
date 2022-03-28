import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../model/weather_data.dart';

class WeatherlinkData {
  static const _apiKey = 'ohmnrgzurma7y6zubutql6dpy2vka6xk';
  static const _secret = 'rtlwzzja2c3hl5gkueomt0bnebtig45p';

  static const _stationId = '112912';

  static const endPointUrl =
      'https://api.weatherlink.com/v2/current/$_stationId';
  final httpClient = http.Client();

  // static final secondsFromUnixTime = (DateTime.now().millisecondsSinceEpoch)/1000;
  //
  // static final textToHash = "api-key${_apiKey}station-id${_stationId}t${(secondsFromUnixTime).toString()}";
  //
  // String computedHash = Hmac(sha1, utf8.encode(_secret)).convert(utf8.encode(textToHash)).toString();


  Future<WeatherData> getWeather() async {
    final secondsFromUnixTime = ((DateTime.now().millisecondsSinceEpoch)/1000).round();
    final textToHash = "api-key${_apiKey}station-id${_stationId}t${(secondsFromUnixTime).toString()}";
    String computedHash = Hmac(sha256, utf8.encode(_secret)).convert(utf8.encode(textToHash)).toString();

    final requestUrl = "$endPointUrl?api-key=$_apiKey&t=$secondsFromUnixTime&api-signature=$computedHash";

    print(requestUrl);

    final response = await httpClient.get(Uri.parse(requestUrl));

    return WeatherData.fromWeatherlink(jsonDecode(response.body));
  }
}
