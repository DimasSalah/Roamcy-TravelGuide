import '../resources/resources.dart';

String weatherFormatAnimation(String? weather) {
  if (weather == null) return Lotties.sunny;

  switch (weather.toLowerCase()) {
    case 'fog':
      return Lotties.cloudy;
    case 'clear':
      return Lotties.sunny;
    case 'clouds':
      return Lotties.cloudy;
    case 'shower rain':
      return Lotties.rainy;
    case 'thunderstorm':
      return Lotties.thunder;
    default:
      return Lotties.sunny;
  }
}
