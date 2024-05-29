import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/db/medicos.dart';
import 'package:proyecto_consultorio/pages/inicio.dart';
import 'package:proyecto_consultorio/pages/login.dart';
//importar de la base
import 'package:proyecto_consultorio/db/usuarios.dart';
//LocalStorage
import 'package:proyecto_consultorio/utils/storage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserDB.conecctUsers();
  await MedicosDB.conecctMedicos();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanaTec',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: _checkAndNavigate(context),
    );
  }
}

Widget _checkAndNavigate(BuildContext context) {
  return FutureBuilder<Map<String, dynamic>>(
    future: getSessionData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        Map<String, dynamic> userData = snapshot.data!;
        if (userData.containsKey('sesionIniciada') && userData['sesionIniciada'] == true) {
          return const Inicio();
        } else {
          return login(); // return login()
        }
      } else {
        return login(); // Default to login() if no data or error
      }
    },
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}