import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:home_work/const/color.dart';
import 'package:home_work/const/font.dart';
import 'package:home_work/const/image.dart';
import 'package:home_work/model/weather_model.dart';
import 'package:home_work/ui/progress_view.dart';
import 'package:home_work/view_model/weather_view_model.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherViewModel viewModel = WeatherViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressView(
        viewModel: viewModel,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
          decoration: const BoxDecoration(
              color: Color(0xFFE5E5E5),
              image: DecorationImage(
                  image: AssetImage(ImageAssets.icBackground),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
            child: StreamBuilder<WeatherModel>(
                stream: viewModel.weatherSubject.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherModel> snapshot) {
                  final data = snapshot.data ?? WeatherModel.empty();
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'LOADING',
                        style: textStyle(),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              ImageAssets.icMenu,
                              height: 30,
                              width: 30,
                            ),
                            Text(
                              data.city.name,
                              style: textStyle(),
                            ),
                            Image.asset(
                              ImageAssets.icSetting,
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(ImageAssets.icBigSunny),
                                    Text(
                                      '${data.list.first.temp.average.toStringAsFixed(1)}°C',
                                      style: textStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 52),
                                    ),
                                    const Text(
                                      'Sunny',
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      DateFormat('EEEE, d MMM')
                                          .format(DateTime.now()),
                                      style: textStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          containerWidget(
                                              image: ImageAssets.icWind,
                                              until: 'km/h',
                                              value: data.list.first.wind_speed
                                                  .toString()),
                                          containerWidget(
                                              image: ImageAssets.icHumidity,
                                              until: '%',
                                              value: data.list.first.humidity
                                                  .toString(),
                                              padding: 20),
                                          containerWidget(
                                              image: ImageAssets.icWind,
                                              until: 'mmHg',
                                              value: data.list.first.pressure
                                                  .toString(),
                                              padding: 15),
                                        ],
                                      ),
                                      Expanded(
                                          child: GridView.count(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 28,
                                        childAspectRatio: 5 / 2,
                                        children: [
                                          containerTemp(
                                              image: ImageAssets.icAverageMax,
                                              title: 'Average max',
                                              value: data
                                                  .list.first.temp.average_max
                                                  .toStringAsFixed(2)),
                                          containerTemp(
                                              image: ImageAssets.icAverageMin,
                                              title: 'Average min',
                                              value: data
                                                  .list.first.temp.average_min
                                                  .toStringAsFixed(2)),
                                          containerTemp(
                                              image: ImageAssets.recordMax,
                                              title: 'Record max',
                                              value: data
                                                  .list.first.temp.record_max
                                                  .toStringAsFixed(2)),
                                          containerTemp(
                                              image: ImageAssets.recordMin,
                                              title: 'Record min',
                                              value: data
                                                  .list.first.temp.record_min
                                                  .toStringAsFixed(2)),
                                        ],
                                      ))
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

  Widget containerWidget(
      {required String until,
      required String image,
      required String value,
      double padding = 25.0}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: padding),
      decoration: BoxDecoration(
        color: containerWeatherColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Image.asset(image),
          const SizedBox(
            height: 6,
          ),
          Text(
            value,
            style: textStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          Text(
            until,
            style: textStyle(fontSize: 12, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget containerTemp({
    required String image,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              value,
              style: textStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Image.asset(image),
      ],
    );
  }
}
