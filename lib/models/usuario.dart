import 'dart:convert';

import 'package:healthy_app/models/rol.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    this.edad,
    this.sexo,
    this.fechaNacimiento,
    this.paisResidencia,
    this.paisOrigen,
    this.peso,
    this.altura,
    required this.email,
    required this.rol,
    required this.antecedentesFamiliares,
    required this.enfermedadesUsuario,
    required this.habitosVida,
    required this.resultadosExamenes,
  });

  String id;
  String nombre;
  String apellidos;
  int? edad;
  String? sexo;
  DateTime? fechaNacimiento;
  String? paisResidencia;
  String? paisOrigen;
  int? peso;
  int? altura;
  String email;
  Rol rol;
  List<dynamic> antecedentesFamiliares;
  List<dynamic> enfermedadesUsuario;
  List<dynamic> habitosVida;
  List<dynamic> resultadosExamenes;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        edad: json["edad"],
        sexo: json["sexo"],
        fechaNacimiento: json["fechaNacimiento"] != null
            ? DateTime.parse(json["fechaNacimiento"])
            : null,
        paisResidencia: json["paisResidencia"],
        paisOrigen: json["paisOrigen"],
        peso: json["peso"],
        altura: json["altura"],
        email: json["email"],
        rol: Rol.fromJson(json["rol"]),
        antecedentesFamiliares:
            List<dynamic>.from(json["antecedentesFamiliares"].map((x) => x)),
        enfermedadesUsuario:
            List<dynamic>.from(json["enfermedadesUsuario"].map((x) => x)),
        habitosVida: List<dynamic>.from(json["habitosVida"].map((x) => x)),
        resultadosExamenes:
            List<dynamic>.from(json["resultadosExamenes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "edad": edad,
        "sexo": sexo,
        "fechaNacimiento": fechaNacimiento!.toIso8601String(),
        "paisResidencia": paisResidencia,
        "paisOrigen": paisOrigen,
        "peso": peso,
        "altura": altura,
        "email": email,
        "rol": rol.toJson(),
        "antecedentesFamiliares":
            List<dynamic>.from(antecedentesFamiliares.map((x) => x)),
        "enfermedadesUsuario":
            List<dynamic>.from(enfermedadesUsuario.map((x) => x)),
        "habitosVida": List<dynamic>.from(habitosVida.map((x) => x)),
        "resultadosExamenes":
            List<dynamic>.from(resultadosExamenes.map((x) => x)),
      };
}
