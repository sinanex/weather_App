import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/api.dart';
import 'package:weather/view/splash/splash.dart';

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
      ], child:   const CupertinoApp(
             
          theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(),
            brightness: Brightness.light ,
          ),
          debugShowCheckedModeBanner: false,
          home:  SplashScreen(),
        ),
      
    );
  }
}