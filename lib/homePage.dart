import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/api.dart';
import 'package:weather/settings.dart';

class HomePage extends StatefulWidget {

   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchCtrl = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FetchData>(context,listen: false).displayData("malappuram");
  }
  @override
  Widget build(BuildContext context) {


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
                          controller: searchCtrl,
                          suffix: IconButton(icon: const Icon( CupertinoIcons.search),onPressed: () {
                            api.displayData(searchCtrl.text);
                            searchCtrl.clear();
                          },),
                          onSubmitted: (value) {
                            api.displayData(value);
                
                          },
                          placeholder: 'search a city',
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
                                    TextStyle(fontSize: 50, color: Colors.grey),
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
                    // Consumer<FetchData>(
                    //   builder: (context, value, child) => Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                         
                    //       Text(
                    //         "high : ${double.parse(value.maxtemp??'0').toInt()}°",
                    //         style: textstyle(),
                    //       ),
                    //       const SizedBox(width: 30),
        
                    //       Text(
                    //         "Low : ${double.parse(value.mintemp??"0").toInt()}°",
                    //         style: textstyle(),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Consumer<FetchData>(
                   builder: (context, feelLikw, child) => Text("Feels like : ${double.parse(feelLikw.feelLike!).toInt()}°")),
                    const SizedBox(height: 30),
                    Consumer<FetchData>(
                      builder: (context, img, child) => Image.asset(
                        img.selectedImage??'assets/images/drizzle.png',
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
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      
                        children: [
                       wethercon(name: 'wind'),
                       wethercon(name: 'pressure'),
                       wethercon(name: 'humidity'),
                      
                        ],
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

  Container wethercon({required String name,String? data}) {
    return Container(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        Text("data")
      ],
     ),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[100],
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


