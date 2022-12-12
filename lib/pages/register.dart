import 'package:flutter/material.dart';
import 'package:healthy_app/helpers/mostrar_alerta.dart';
import 'package:healthy_app/services/auth_services.dart';

import 'package:healthy_app/widgets/custom_input_form.dart';
import 'package:healthy_app/widgets/custom_button.dart';
import 'package:healthy_app/widgets/labels.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
  void dispose() {
    nombresCtrl.dispose();
    apellidosCtrl.dispose();
    correoCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomInputForm(
            textController: nombresCtrl,
            texto: "Nombre(s):",
          ),
          CustomInputForm(
            textController: apellidosCtrl,
            texto: "Apellido(s):",
          ),
          CustomInputForm(
            textController: correoCtrl,
            texto: "Correo:",
          ),
          CustomInputForm(
            textController: passCtrl,
            texto: "Clave:",
          ),
          SizedBox(height: 20),
          CustomButton(
            texto: "Registrarse",
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (nombresCtrl.text.isEmpty ||
                        apellidosCtrl.text.isEmpty ||
                        correoCtrl.text.isEmpty ||
                        passCtrl.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Debe completar la información"),
                        ),
                      );
                    } else {
                      final registroOk = await authServices.register(
                          nombresCtrl.text.trim(),
                          apellidosCtrl.text.trim(),
                          correoCtrl.text.trim(),
                          passCtrl.text.trim());
                      print(registroOk);
                      if (registroOk["ok"]) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(registroOk["msg"]),
                              ),
                            )
                            .closed
                            .then((_) => Navigator.pushReplacementNamed(
                                context, "loading"));
                      } else {
                        mostrarAlerta(
                            context, "Registro incorrecto", registroOk["msg"]);
                      }
                    }
                  },
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
