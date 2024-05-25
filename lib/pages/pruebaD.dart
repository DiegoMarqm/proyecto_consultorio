import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/utils/storage.dart';
import 'package:proyecto_consultorio/pages/login.dart';

class Prueba extends StatefulWidget {
  @override
  State<Prueba> createState() => _pruebaState();
}

class _pruebaState extends State<Prueba> {
  String _nombreUsuario = ""; // Inicializar _nombreUsuario con una cadena vacía

  Future<void> _loadData() async {
    // Recuperar datos de usuario del almacenamiento
    Map<String, dynamic> userData = await getSessionData();
    if (userData.isNotEmpty) {
      setState(() { // Usar setState para actualizar la interfaz de usuario en base a los datos
        _nombreUsuario = userData['nombre'];
      });
    }
    print(userData['nombre']);
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Cargar datos al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba', style: TextStyle(color: Colors.blue)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hola "),
              Text(_nombreUsuario), // Usar la variable de estado aquí
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async{
                await deleteSessionData();
                // Navegar de vuelta a la pantalla de inicio de sesión
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
                child: Text('Cerrar Sesión'),
              ),

            ],
          )


        ],
      ),
    );
  }
}