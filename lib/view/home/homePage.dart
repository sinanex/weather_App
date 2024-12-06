// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<FetchData>(context, listen: false).displayData("malappuram");
  }
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FetchData>(context).temperature;
    if (data == null) {
      return const CupertinoPageScaffold(
          child: Center(child: CupertinoActivityIndicator()));
    }
    return CupertinoPageScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: CupertinoColors.systemGrey,
                              )),
                          controller: searchCtrl,
                          suffix: CupertinoButton(
                            child: const Icon(CupertinoIcons.search),
                            onPressed: () {
                              api.displayData(searchCtrl.text);
                              searchCtrl.clear();
                            },
                          ),
                          onSubmitted: (value) {
                            api.displayData(value);
                          },
                          placeholder: ' search a city',
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    )),
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
                        color: CupertinoColors.systemGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
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
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              );
                            } else {
                              return const Text(
                                "0",
                                style:
                                    TextStyle(fontSize: 50, color: CupertinoColors.systemGrey),
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
                    Consumer<FetchData>(
                        builder: (context, feelLikw, child) => Text(
                            "Feels like : ${double.parse(feelLikw.feelLike ?? '0').toInt()}°")),
                    const SizedBox(height: 30),
                    Consumer<FetchData>(
                      builder: (context, img, child) => Image.asset(
                        img.selectedImage ?? 'assets/images/clouds.png',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Consumer<FetchData>(
                        builder: (context, time, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            wethercon(
                                name: 'sun rise',
                                width: 170,
                                data: DateFormat('hh:mm a').format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        int.parse(time.sunRise ?? '0')))),
                            wethercon(
                                name: 'sun set',
                                width: 170,
                                data: DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(time.sunSet ?? '0') * 1000)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Consumer<FetchData>(
                        builder: (context, wetherData, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            wethercon(
                                name: 'wind',
                                data: "${wetherData.windSpeed ?? '0'} m/s"),
                            wethercon(
                                name: 'pressure',
                                data: "${wetherData.pressure ?? '0'} hPa"),
                            wethercon(
                                name: 'humidity',
                                data: "${wetherData.humidty ?? '0'}%"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container wethercon(
      {required String name, String? data, double? width = 100}) {
    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 243, 243, 245),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black,
            ),
          ),
          Text(
            data ?? '0',
            style: const TextStyle(color: CupertinoColors.black),
          )
        ],
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
    color: CupertinoColors.systemGrey,
    fontSize: 20,
  );
}
