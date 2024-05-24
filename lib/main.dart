import 'package:flutter/material.dart';
import 'package:proyecto_consultorio/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmacias Similares',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Consultorio'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title),
      ),
      body:  Center(
        child: ElevatedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => login()));
            },
            child: Text("Ir a Inicia Sesión"),
        ),
       /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aquí va estar una chingonada de App 🤠',
            ),
          ],
        ),*/
     ),
    );
  }
}
