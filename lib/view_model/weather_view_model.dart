import 'package:home_work/model/weather_model.dart';
import 'package:home_work/service.dart';
import 'package:rxdart/rxdart.dart';

class WeatherViewModel {
  Service service = Service();

  BehaviorSubject<bool> progressSubject = BehaviorSubject.seeded(true);

  BehaviorSubject<WeatherModel> weatherSubject = BehaviorSubject();

  initData() async {
    progressSubject.add(true);
    WeatherModel data = await service.getWeather('New York');
    weatherSubject.add(data);
    progressSubject.add(false);
  }
}
