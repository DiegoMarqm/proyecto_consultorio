import 'package:proyecto_consultorio/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';

const citasCole = "citas";

class CitasDB {
  static var db, coleccionCitas;

  static conecctCitas() async {
    try {
      db = await Db.create(mongoConecctionURL);
      await db.open();
      coleccionCitas = db.collection(citasCole);
      print("Conexion exitosa");
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getCitas(String fecha) async {
    try {
      final citas = await coleccionCitas.find({'fecha': fecha}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getCitasFecha(String fecha, nombre) async {
    try {
      final citas = await coleccionCitas.find({'fecha': fecha,'nom_doctor':nombre}).toList();
      print("Citas obtenidas con exito");
      return citas;
    } catch (e) {
      print('Error al obtener las citas: $e');
      return [];
    }
  }
}