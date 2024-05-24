import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class login extends StatefulWidget{
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _ocultarContra = true;

  @override
Widget build(BuildContext context){
    return  Scaffold(

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Center(
          //child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //children: [
              SizedBox(height: 50),
                Text("Bienvenidos",
                  style:TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight:  FontWeight.bold,
                  ),
                ),
              Icon(Icons.favorite,
                size: 180,
                color: Colors.blue,
              ),
              Text("Iniciar sesión",
                style:TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight:  FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Text("Inicie sesión para agendar su cita médica",
                      style: TextStyle(
                      ),
                    ),
                  ),
                ],
              ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
              child: Text("Teléfono",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Ingrese su telefono",
                    border: OutlineInputBorder(),
                  ),
                ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Contraseña",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
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
            child: ElevatedButton(onPressed: () {  },
              child: Text("Ingresar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                  child: Text("Crear cuenta",
                  style: TextStyle(color: Colors.cyan),),
                  onTap: () {

                  },
                splashColor: Colors.transparent,
              ),
            ),
            //],
          //),
          //),
        ],
      ),
    );
  }
}