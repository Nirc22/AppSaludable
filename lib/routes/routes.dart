import 'package:flutter/material.dart';
import 'package:healthy_app/pages/login.dart';
import 'package:healthy_app/pages/register.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "login": (BuildContext context) => LoginPage(),
  "register": (BuildContext context) => RegisterPage(),
};
