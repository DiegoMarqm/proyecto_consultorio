import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';

const mongoConecctionURL = "mongodb+srv://Diego:consultoriopassword@cluster0.hed601j.mongodb.net/consultorio?retryWrites=true&w=majority&appName=Cluster0";
const coleccion = "usuarios";

class MongoDB{
  static var db, coleccionUsuarios;
  static conecct() async{
    try {
      db = await Db.create(mongoConecctionURL);
      await db.open();
      inspect(db);
      coleccionUsuarios = db.collection(coleccion);
      print("Conexion exitosa");
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    try {
      final usuarios = await coleccionUsuarios.find().toList();
      print("Usuarios obtenidos con exito");
      return usuarios;

    } catch (e) {
      print('Error al obtener los usuarios: $e');
      return [];
    }
  }
}