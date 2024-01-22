import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_service.dart';
class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<StatefulWidget> createState() =>_WeatherPageState();
}
class _WeatherPageState extends State<WeatherPage>{
  // api key
  final _weatherService =WeatherService(apiKey: '71357fda77b3d4d40ebe840b93704f6f');
  Weather? _weather;
  // fetch weather

  _fetchWeather()async{
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather =await _weatherService.getWeather(cityName);
       setState(() {
         _weather = weather;
       });
    }
    // any errors
    catch(e){ print(e);}
  }
  // weather animation
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null){
      return 'assets/sunny.json';}
      switch(mainCondition.toLowerCase()){
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloud.json';

        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/rain.json';
        case 'thunder storm':
          return 'assets/storm.json';
        case 'clear':
         return 'assets/sunny.json';
        default:
          return'assets/sunny.json';


      }

  }
  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(_weather?.cityName ??  "loading city ..."),
           Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
           Text('${_weather?.temperature.round()}c' ),
           Text(_weather?.mainCondition??""),
         ],
        ),
      ),
    );
  }

}