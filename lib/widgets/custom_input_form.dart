import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputForm extends StatelessWidget {
  final String texto;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isActive;
  final List<TextInputFormatter>? formatoInputs;

  const CustomInputForm({
    Key? key,
    required this.texto,
    this.keyboardType = TextInputType.text,
    this.isActive = true,
    required this.textController,
    this.formatoInputs,
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
            enabled: isActive,
            controller: textController,
            keyboardType: keyboardType,
            inputFormatters: formatoInputs,
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
