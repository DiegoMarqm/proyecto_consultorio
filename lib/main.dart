import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/pages/login.dart';
import 'package:proyecto_consultorio/pages/home.dart';
import 'package:proyecto_consultorio/pages/crearCuenta.dart';
import 'package:proyecto_consultorio/pages/cambiarContra.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';
import 'package:proyecto_consultorio/pages/citaAgendada.dart';

//importar de la base
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/pages/pruebaD.dart';

//LocalStorage
import 'package:proyecto_consultorio/utils/storage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserDB.conecctUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SanaTec',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
          return Home();

        } else {
          return Home(); // return login()
        }
      } else {
        return Home(); // Default to login() if no data or error
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