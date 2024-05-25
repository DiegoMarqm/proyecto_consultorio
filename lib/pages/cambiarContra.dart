import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class changePass extends StatefulWidget{
  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {
  bool _ocultarContra = true;

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(
        title: Text("Cambiar contraseña",
          style:TextStyle(
            color: Colors.blue,
            fontSize: 25,
            fontWeight:  FontWeight.bold,
          ),
        ),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Para garantizar la seguridad de su cuenta, te recomendamos cambiar su contraseña regularmente.",
                  ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
              child: Text("Por favor, ingresa una nueva contraseña que deseas utilizar",
              ),
            ),
          ),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Nueva contraseña",
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
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 5),
                child: Text("Verifique la contraseña",
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
              child: Text("Aceptar",
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