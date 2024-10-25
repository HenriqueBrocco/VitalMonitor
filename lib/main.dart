import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:topicos_4/db.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await HiveConfig.start();
  DB(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VitalMonitor',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Color.fromRGBO(73, 104, 141, 1)),
        ),
      ),
      home: const Login(),
    );
  }
}