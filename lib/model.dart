class Whether {
  final String cityName;
  final String temeprature;
  final String contition;
  final String wind;
  final String mintemp;
  final String maxtemp;
  final String feelLike;

  Whether(
      {required this.cityName,
      required this.temeprature,
      required this.contition,
      required this.maxtemp,
      required this.mintemp,
      required this.feelLike,
      required this.wind});

  factory Whether.fromJson(Map<String, dynamic> json) {
    return Whether(
      feelLike: json['main']['feels_like'].toString(),
      maxtemp: json['main']['temp_max'].toString(),
      mintemp: json['main']['temp_min'].toString(),
      cityName: json['name'],
      temeprature: json['main']['temp'].toString(),
      contition: json['weather'][0]['main'],
      wind: json['wind']['speed'].toString(),
    );
  }
}
