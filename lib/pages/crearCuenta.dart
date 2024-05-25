import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class sign extends StatefulWidget{
  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  bool _ocultarContra = true;

  @override
  Widget build(BuildContext context){
    return  Scaffold(

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text("Crear cuenta",
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
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Nombre",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 5),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Ingrese su nombre",
                border: OutlineInputBorder(),
              ),
            ),
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
        ],
      ),
    );
  }
}