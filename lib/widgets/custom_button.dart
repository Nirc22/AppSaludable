import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final Function()? onPressed;

  const CustomButton({Key? key, required this.texto, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: const StadiumBorder(),
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
