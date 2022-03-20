import 'package:dio/dio.dart';
import 'package:home_work/model/weather_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Service {
  Dio dio = Dio();

  // Service () {
  //   dio.interceptors.add(PrettyDioLogger());
  //   dio.interceptors.add(PrettyDioLogger(
  //       requestHeader: true,
  //       requestBody: true,
  //       responseBody: true,
  //       responseHeader: false,
  //       error: true,
  //       compact: true,
  //       maxWidth: 90));  }

  Future<WeatherModel> getWeather(String country) async {
    try {
      var response = await dio.get(
          'https://community-open-weather-map.p.rapidapi.com/climate/month',
          queryParameters: {'q': country},
          options: Options(headers: {
            'x-rapidapi-host': 'community-open-weather-map.p.rapidapi.com',
            'x-rapidapi-key':
                '0cacc02ed0msh38adac972d5f373p18f039jsn1245f41a7791'
          }));

      final Map<String, dynamic> jsonData = response.data as Map<String, dynamic>;

      WeatherModel model = WeatherModel.fromJson(jsonData);

      return model;
    } catch (e) {
      print(e);
    }

    return WeatherModel.empty();
  }
}
