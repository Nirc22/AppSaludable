import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¿No tienes cuenta?",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "register");
                },
                child: const Text(
                  "Crea una ahora",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Terminos y condiciones de uso",
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
