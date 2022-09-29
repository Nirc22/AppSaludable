import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthy_app/services/auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final datos = authServices.loginResponse;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hola, ${datos.name}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            MaterialButton(
              onPressed: () {
                AuthServices.deleteToken();
                Navigator.pushReplacementNamed(context, "login");
              },
              child: Text(
                "Salir",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
