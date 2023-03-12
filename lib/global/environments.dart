import 'dart:io';

class Enviroments {
  static String apiUrl = Platform.isAndroid
      ? "https://back-appsaludable.up.railway.app/api"
      : "https://back-appsaludable.up.railway.app/api";
  // ? "http://192.168.1.111:4001/api"
  // : "http://localhost:4001/api";
}
