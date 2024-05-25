import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_consultorio/db/usuarios.dart';
import 'package:proyecto_consultorio/pages/login.dart';

class sign extends StatefulWidget{
  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  bool _ocultarContra = true;

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  Future<void> _registrarUsuario() async{
    String nombre = _nombreController.text;
    String telefono = _telefonoController.text;
    String contrasena = _contrasenaController.text;

    if(nombre.isEmpty || telefono.isEmpty || contrasena.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor llene todos los campos"),
        ),
      );
      return;
    }

    Map<String, dynamic> usuario = {
      "nom_user": nombre,
      "telefono": telefono,
      "pass": contrasena,
    };

    try{
      await MongoDB.coleccionUsuarios.insertOne(usuario);
      _nombreController.clear();
      _telefonoController.clear();
      _contrasenaController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario Registrado con exito"),
          backgroundColor: Colors.green,
        ),
      );
      print("Usuario Registrado");
    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al registrar el usuario"),
          backgroundColor: Colors.red,
        ),
      );
      print("Error al registrar el usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Text("Crear cuenta",
            style:TextStyle(
              color: Colors.blue,
              fontSize: 30,
              fontWeight:  FontWeight.bold,
            ),
          ),
          const Icon(Icons.favorite,
            size: 180,
            color: Colors.blue,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Nombre",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              controller: _nombreController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Ingrese su nombre",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Teléfono",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              controller: _telefonoController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Ingrese su telefono",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Contraseña",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              controller: _contrasenaController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_ocultarContra ? Icons.visibility_off : Icons.visibility),
                  onPressed: (){
                    setState((){
                      _ocultarContra = !_ocultarContra;
                    }
                    );
                  },
                ),
              ),
              obscureText: _ocultarContra,
              obscuringCharacter: "*",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(onPressed: () {
              _registrarUsuario();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );

            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              child: const Text("Ingresar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}