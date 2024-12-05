import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/api.dart';
import 'package:weather/homePage.dart';
import 'package:weather/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => themeChangeProvider()),
        ChangeNotifierProvider(create: (context) => FetchData(),),
      ],
      child: Consumer<themeChangeProvider>(
        builder: (context, theme, child) =>  CupertinoApp(
             
          theme: CupertinoThemeData(
            textTheme: const CupertinoTextThemeData(),
            brightness: theme.theme ,
          ),
          debugShowCheckedModeBanner: false,
          home:  HomePage(),
        ),
      ),
    );
  }
}