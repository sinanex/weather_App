import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/api.dart';
import 'package:weather/splash.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FetchData(),),
      ], child:   CupertinoApp(
             
          theme: CupertinoThemeData(
            textTheme: const CupertinoTextThemeData(),
            brightness: Brightness.light ,
          ),
          debugShowCheckedModeBanner: false,
          home:  SplashScreen(),
        ),
      
    );
  }
}