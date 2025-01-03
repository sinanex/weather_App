class Whether {
  final String cityName;
  final String temeprature;
  final String contition;
  final String wind;
  final String mintemp;
  final String maxtemp;
  final String feelLike;
  final String pressure;
  final String humidity;
  final String sunRise;
  final String sunSet;

  Whether(
      {required this.cityName,
      required this.temeprature,
      required this.contition,
      required this.maxtemp,
      required this.mintemp,
      required this.feelLike,
      required this.humidity,
      required this.pressure,
      required this.sunRise,
      required this.sunSet,
      required this.wind});

  factory Whether.fromJson(Map<String, dynamic> json) {
    return Whether(
      feelLike: json['main']['feels_like'].toString(),
      maxtemp: json['main']['temp_max'].toString(),
      mintemp: json['main']['temp_min'].toString(),
      cityName: json['name'].toString(),
      temeprature: json['main']['temp'].toString(),
      contition: json['weather'][0]['main'],
      wind: json['wind']['speed'].toString(),
      humidity: json['main']['humidity'].toString(),
      pressure: json['main']['pressure'].toString(),
      sunRise: json['sys']['sunrise'].toString(),
      sunSet: json['sys']['sunset'].toString(),
    );
  }
}
