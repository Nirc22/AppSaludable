import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    required this.msg,
    required this.uid,
    required this.name,
    required this.rol,
    required this.token,
  });

  bool ok;
  String msg;
  String uid;
  String name;
  String rol;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        uid: json["uid"],
        name: json["name"],
        rol: json["rol"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "uid": uid,
        "name": name,
        "rol": rol,
        "token": token,
      };
}
