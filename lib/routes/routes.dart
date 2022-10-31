import 'package:flutter/material.dart';

import 'package:healthy_app/pages/login.dart';
import 'package:healthy_app/pages/register.dart';
import 'package:healthy_app/pages/loading.dart';
import 'package:healthy_app/pages/tabs_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "login": (BuildContext context) => LoginPage(),
  "register": (BuildContext context) => RegisterPage(),
  "loading": (BuildContext context) => LoadingPage(),
  "tabs": (BuildContext context) => TabsPage(),
};
