import 'package:flutter/material.dart';
import 'package:healthy_app/pages/home.dart';
import 'package:healthy_app/pages/loading.dart';
import 'package:healthy_app/pages/login.dart';
import 'package:healthy_app/pages/register.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "login": (BuildContext context) => LoginPage(),
  "register": (BuildContext context) => RegisterPage(),
  "home": (BuildContext context) => HomePage(),
  "loading": (BuildContext context) => LoadingPage()
};
