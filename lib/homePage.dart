import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/api.dart';
import 'package:weather/provider.dart';
import 'package:weather/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<FetchData>(
                      builder: (context, api, child) => CupertinoTextField(
                        suffix: Icon(CupertinoIcons.search),
                        onSubmitted: (value) {
                          api.displayData(value);
                        },
                        placeholder: 'search city',
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                    icon: const Icon(CupertinoIcons.settings),
                  ),
                ],
              ),
            ),
            Consumer<FetchData>(builder: (context, apiFetch, child) {
              return Text(
                apiFetch.city ?? "search a city",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              );
            }),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "in sync",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "${DateTime.now().day.toString() + " " + _getMonthName(DateTime.now().month).toString() + " " + DateTime.now().year.toString()}",
                    style: textstyle(),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<FetchData>(
                        builder: (context, temp, child) {
                          if (temp.temperature != null &&
                              double.tryParse(temp.temperature!) != null) {
                            final tempa =
                                double.parse(temp.temperature!).toInt();
                            return Text(
                              '$tempa',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return const Text(
                              "Loading data...",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            );
                          }
                        },
                      ),
                      const Text(
                        "°C",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.down_arrow),
                      Text(
                        "22 °c",
                        style: textstyle(),
                      ),
                      const SizedBox(width: 20),
                      const Icon(CupertinoIcons.up_arrow),
                      Text(
                        "29 °c",
                        style: textstyle(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Consumer<themeChangeProvider>(
                    builder: (context, value, child) => Image.asset(
                      'assets/images/rainy.png',
                      color: value.imageColor,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<FetchData>(
                    builder: (context, apiFetch, child) => Text(
                      apiFetch.condition ?? "Loading...",
                      style: textstyle(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.wind_snow),
                      Consumer<FetchData>(
                        builder: (context, windSpeeed, child) => 
                    Text(
                          "${windSpeeed.windSpeed ??'0'} m/s W",
                          style: textstyle(),
                        ),
                      ),
                      const SizedBox(width: 30),
                      const Icon(CupertinoIcons.sunset),
                      Text(
                        "5:55 PM",
                        style: textstyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}

TextStyle textstyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontSize: 20,
  );
}
