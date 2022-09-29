import 'package:flutter/material.dart';
import 'package:healthy_app/routes/routes.dart';
import 'package:healthy_app/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthServices(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Healthy App',
        initialRoute: "login",
        routes: appRoutes,
      ),
    );
  }
}
