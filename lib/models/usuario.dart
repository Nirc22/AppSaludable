import 'dart:convert';

import 'package:healthy_app/models/pais.dart';
import 'package:healthy_app/models/rol.dart';
import 'package:healthy_app/models/tipoRiesgo.dart';

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
    this.imc,
    required this.email,
    required this.rol,
    required this.antecedentesFamiliares,
    required this.enfermedadesUsuario,
    required this.habitosVida,
    required this.resultadosExamenes,
    this.riesgoUsuario,
    this.tipoRiesgo,
    required this.isCompleteData,
  });

  String id;
  String nombre;
  String apellidos;
  int? edad;
  String? sexo;
  DateTime? fechaNacimiento;
  Pais? paisResidencia;
  Pais? paisOrigen;
  int? peso;
  int? altura;
  double? imc;
  String email;
  Rol rol;
  List<dynamic> antecedentesFamiliares;
  List<dynamic> enfermedadesUsuario;
  List<dynamic> habitosVida;
  List<dynamic> resultadosExamenes;
  int? riesgoUsuario;
  TipoRiesgo? tipoRiesgo;
  bool isCompleteData;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["_id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        edad: json["edad"],
        sexo: json["sexo"],
        fechaNacimiento: json["fechaNacimiento"] != null
            ? DateTime.parse(json["fechaNacimiento"])
            : null,
        paisResidencia: json["paisResidencia"] != null
            ? Pais.fromJson(json["paisResidencia"])
            : null,
        paisOrigen: json["paisOrigen"] != null
            ? Pais.fromJson(json["paisOrigen"])
            : null,
        peso: json["peso"],
        altura: json["altura"],
        imc: json["imc"] != null ? json["imc"].toDouble() : null,
        email: json["email"],
        rol: Rol.fromJson(json["rol"]),
        antecedentesFamiliares:
            List<dynamic>.from(json["antecedentesFamiliares"].map((x) => x)),
        enfermedadesUsuario:
            List<dynamic>.from(json["enfermedadesUsuario"].map((x) => x)),
        habitosVida: List<dynamic>.from(json["habitosVida"].map((x) => x)),
        resultadosExamenes:
            List<dynamic>.from(json["resultadosExamenes"].map((x) => x)),
        riesgoUsuario: json["riesgoUsuario"],
        tipoRiesgo: json["tipoRiesgo"] != null
            ? TipoRiesgo.fromJson(json["tipoRiesgo"])
            : null,
        isCompleteData: json["isCompleteData"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "edad": edad,
        "sexo": sexo,
        "fechaNacimiento": fechaNacimiento!.toIso8601String(),
        "paisResidencia": paisResidencia!.toJson(),
        "paisOrigen": paisOrigen!.toJson(),
        "peso": peso,
        "altura": altura,
        "imc": imc,
        "email": email,
        "rol": rol.toJson(),
        "antecedentesFamiliares":
            List<dynamic>.from(antecedentesFamiliares.map((x) => x)),
        "enfermedadesUsuario":
            List<dynamic>.from(enfermedadesUsuario.map((x) => x)),
        "habitosVida": List<dynamic>.from(habitosVida.map((x) => x)),
        "resultadosExamenes":
            List<dynamic>.from(resultadosExamenes.map((x) => x)),
        "riesgoUsuario": riesgoUsuario,
        "tipoRiesgo": tipoRiesgo!.toJson(),
        "isCompleteData": isCompleteData,
      };
}
