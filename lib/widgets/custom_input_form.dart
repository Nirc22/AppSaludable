import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final String texto;
  final TextEditingController textController;
  final TextInputType keyboardType;

  const CustomInputForm({
    Key? key,
    required this.texto,
    this.keyboardType = TextInputType.text,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            texto,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: textController,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
