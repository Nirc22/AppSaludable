import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  CustomInput({
    Key? key,
    required this.icon,
    required this.placeholder,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool hiddenValue;

  @override
  void initState() {
    hiddenValue = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: widget.textController,
        autocorrect: false,
        keyboardType: widget.keyboardType,
        obscureText: hiddenValue,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: widget.placeholder,
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  onPressed: () {
                    hiddenValue = !hiddenValue;
                    setState(() {});
                  },
                  icon: (hiddenValue)
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off))
              : SizedBox(),
        ),
      ),
    );
  }
}
