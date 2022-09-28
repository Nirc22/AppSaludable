import 'package:flutter/material.dart';
import 'package:healthy_app/widgets/custom_button.dart';
import 'package:healthy_app/widgets/labels.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LabelRegistro(),
                Formulario(),
                Labels(
                  ruta: "login",
                  texto: "¿Ya tienes una cuenta?",
                  subtexto: "Inicia sesión",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatefulWidget {
  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _CustomInputForm(
            textController: nombresCtrl,
            texto: "Nombre(s):",
          ),
          _CustomInputForm(
            textController: apellidosCtrl,
            texto: "Apellido(s):",
          ),
          _CustomInputForm(
            textController: correoCtrl,
            texto: "Correo:",
          ),
          _CustomInputForm(
            textController: passCtrl,
            texto: "Clave:",
          ),
          CustomButton(
            texto: "Registrarse",
            onPressed: () {
              print(nombresCtrl.text);
              print(apellidosCtrl.text);
              print(correoCtrl.text);
              print(passCtrl.text);
            },
          ),
        ],
      ),
    );
  }
}

class _CustomInputForm extends StatelessWidget {
  final String texto;
  final TextEditingController textController;
  final TextInputType keyboardType;

  const _CustomInputForm({
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
              fontSize: 18,
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

class _LabelRegistro extends StatelessWidget {
  const _LabelRegistro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        "Registro",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
