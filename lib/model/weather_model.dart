import 'dart:convert';

import 'dart:math';

class WeatherModel {
  String cod = '';
  City city = City.empty();
  List<ItemListWeather> list = [];

  WeatherModel.empty();

  WeatherModel({
    required this.cod,
    required this.city,
    required this.list,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<ItemListWeather> data = [];
    List<dynamic> list = json['list'];

    ItemListWeather item = ItemListWeather.fromJson(list[0]);
    data.add(item);
    return WeatherModel(
        cod: json['cod'], city: City.fromJson(json['city']), list: data);
  }
}

class City {
  int id = 0;
  String name = '';
  String country = '';

  City.empty();

  City({
    required this.id,
    required this.name,
    required this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['country'],
    );
  }
}

class ItemListWeather {
  double humidity = 0;
  double pressure = 0;
  Temp temp = Temp.empty();
  double wind_speed = 0;

  ItemListWeather.empty();

  ItemListWeather({
    required this.humidity,
    required this.pressure,
    required this.temp,
    required this.wind_speed,
  });

  factory ItemListWeather.fromJson(Map<String, dynamic> json) {
    return ItemListWeather(
      humidity: json['humidity'],
      pressure: json['pressure'],
      temp: Temp.fromJson(json['temp']),
      wind_speed: json['wind_speed'],
    );
  }
}

class Temp {
  double average = 0;
  double average_max = 0;
  double average_min = 0;
  double record_max = 0;
  double record_min = 0;

  Temp.empty();

  Temp({
    required this.average,
    required this.average_max,
    required this.average_min,
    required this.record_max,
    required this.record_min,
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
        average: json['average'] - 245,
        average_max: json['average_max'] - 240,
        average_min: json['average_min'] - 290,
        record_max: json['record_max'] - 235,
        record_min: json['record_min'] - 300);
  }
}
