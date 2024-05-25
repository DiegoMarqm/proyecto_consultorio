import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//almacenar datos del usuario
Future<void> saveSessionData(Map<String, dynamic> userData) async {
  final storage = const FlutterSecureStorage();
  userData['sesionIniciada'] = true;
  await storage.write(key: 'userData', value: jsonEncode(userData));
}

//obtener datos del usuario
Future<Map<String, dynamic>> getSessionData() async {
  final storage = new FlutterSecureStorage();
  String? userDataString = await storage.read(key: 'userData');
  if (userDataString != null) {
    return jsonDecode(userDataString) as Map<String, dynamic>;
  } else {
    return {};
  }
}

// Eliminar token de sesión y datos de usuario
Future<void> deleteSessionData() async {
  final storage = new FlutterSecureStorage();
  await storage.delete(key: 'userData');
}