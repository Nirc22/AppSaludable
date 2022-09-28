import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String texto;
  final String subtexto;
  final String ruta;

  const Labels(
      {Key? key,
      required this.texto,
      required this.ruta,
      required this.subtexto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                texto,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, ruta);
                },
                child: Text(
                  subtexto,
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
