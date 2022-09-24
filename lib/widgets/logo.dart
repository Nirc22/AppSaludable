import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.07),
        width: size.width * 0.4,
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/logo.png"),
            ),
            Text(
              "Healthy App",
              style: TextStyle(
                fontSize: size.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
