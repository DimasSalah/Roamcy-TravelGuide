import 'dart:io';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../utils/constant/api_constant.dart';
import '../models/weather_model.dart';

class WeatherServices {
  final Dio dio = Dio();
  static const String baseUrl = weatherBaseUrl;
  static const String apiKey = weatherApiKey;

  Future<WeatherModel> getWeather(Position position) async {
    print(position.latitude);
    print(position.longitude);
    try {
      final response = await dio.get(
          '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey');
      print(response.data);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }


}
