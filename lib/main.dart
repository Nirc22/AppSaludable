import 'package:flutter/material.dart';
import 'package:healthy_app/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthy App',
      initialRoute: "login",
      routes: appRoutes,
    );
  }
}
