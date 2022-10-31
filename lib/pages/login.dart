import 'package:flutter/material.dart';
import 'package:healthy_app/helpers/mostrar_alerta.dart';
import 'package:healthy_app/services/auth_services.dart';

import 'package:healthy_app/widgets/logo.dart';
import 'package:healthy_app/widgets/labels.dart';
import 'package:healthy_app/widgets/custom_button.dart';
import 'package:healthy_app/widgets/custom_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(),
                _Form(),
                Labels(
                  ruta: "register",
                  texto: "¿No tienes cuenta?",
                  subtexto: "Crea una ahora",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key? key,
  }) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Clave',
            keyboardType: TextInputType.text,
            textController: passCtrl,
            isPassword: true,
          ),
          CustomButton(
            texto: "Ingresar",
            onPressed: authServices.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authServices.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk["ok"]) {
                      Navigator.pushReplacementNamed(context, "loading");
                    } else {
                      mostrarAlerta(
                          context, "Login incorrecto", loginOk["msg"]);
                    }
                  },
          )
        ],
      ),
    );
  }
}
