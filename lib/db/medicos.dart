import 'package:proyecto_consultorio/utils/constantes.dart';
import 'package:mongo_dart/mongo_dart.dart';

const medicosCole = "medicos";

class MedicosDB{
  static var db, coleccionMedicos;

  static conecctMedicos() async {
    try {
      db = await Db.create(mongoConecctionURL);
      await db.open();
      coleccionMedicos = db.collection(medicosCole);
      print("Conexion exitosa");
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getMedicos() async {
    try {
      final medicos = await coleccionMedicos.find().toList();
      print("Medicos obtenidos con exito");
      //print(medicos);
      return medicos;
    } catch (e) {
      print('Error al obtener los medicos: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getMedicosAleatorios() async{
    try {
      final medicosAle = await coleccionMedicos.aggregateToStream([
        {
          '\$sample': {'size': 3}
        }
      ]).toList();
      print("Medicos aleatorios con exito");
      return medicosAle;
    } catch (e) {
      print('Error al obtener los medicos: $e');
      return [];
    }
  }
}