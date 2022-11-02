import 'package:flutter/material.dart';

class NoDataUser extends StatelessWidget {
  const NoDataUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "data"),
      child: Card(
        elevation: 3,
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: Center(
            child: ListTile(
              title: Text(
                "Debe completar la información.",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text("Para generar sus recomendaciones de salud."),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
