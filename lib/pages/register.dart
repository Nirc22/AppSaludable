import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _LabelRegistro(),
              Expanded(
                child: Formularios(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Formularios extends StatefulWidget {
  const Formularios({
    Key? key,
  }) : super(key: key);

  @override
  State<Formularios> createState() => _FormulariosState();
}

class _FormulariosState extends State<Formularios> {
  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.vertical,
      onStepTapped: (value) {
        _currentStep = value;
        setState(() {});
      },
      onStepCancel: () {
        if (_currentStep == 0) {
          Navigator.pushNamed(context, "login");
        } else if (_currentStep >= 1) {
          _currentStep--;
          setState(() {});
        }
      },
      onStepContinue: () {
        if (_currentStep < 2) {
          _currentStep++;
          setState(() {});
        }
      },
      currentStep: _currentStep,
      steps: [
        Step(
          title: const Text(
            "Datos Personales",
          ),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          content: Column(
            children: [
              CustomStepperInput(
                label: "Nombre(s):",
                textController: nombresCtrl,
              ),
              CustomStepperInput(
                label: "Apellido(s):",
                textController: nombresCtrl,
              ),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text("Masculino"),
                    value: "Masculino",
                  ),
                  DropdownMenuItem(
                    child: Text("Femenino"),
                    value: "Femenino",
                  ),
                ],
                onChanged: (String? value) {
                  print(value);
                },
              )
            ],
          ),
        ),
        Step(
          title: const Text(
            "Antecedentes Familiares",
          ),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          content: Container(),
        ),
        Step(
          title: const Text(
            "Antecedentes Personales",
          ),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          content: Container(),
        ),
      ],
    );
  }
}

class CustomStepperInput extends StatelessWidget {
  final String label;
  final TextEditingController textController;
  final TextInputType keyboardType;

  const CustomStepperInput({
    Key? key,
    required this.label,
    required this.textController,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: textController,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
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
