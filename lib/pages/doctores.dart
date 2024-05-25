
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class doctores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctores',style: TextStyle(color:Colors.blue),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Doctor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  DoctorCard(
                    nombre: 'Dr. Gregory House',
                    especialidad: 'Nefrología e infectología',
                    foto: Image.asset('assets/house.jpg'),
                  ),
                  DoctorCard(
                    nombre: 'Dra. Cameron',
                    especialidad: 'Inmunología',
                    foto: Image.asset('assets/cameron.jpg'),
                  ),
                  DoctorCard(
                    nombre: 'Dr. Chase',
                    especialidad: 'Cardiología y cuidados intensivos',
                    foto: Image.asset('assets/chasse.jpg'),
                  ),
                  DoctorCard(
                    nombre: 'Dr. Foreman',
                    especialidad: 'Neurología',
                    foto: Image.asset('assets/foreman.jpg'),
                  ),
                  DoctorCard(
                    nombre: 'Dr. James Wilson',
                    especialidad: 'Oncología',
                    foto: Image.asset('assets/james.jpeg'),
                  ),
                  DoctorCard(
                    nombre: 'Dr. Christopher Taub',
                    especialidad: 'Cirujano Plástico y Reconstructivo',
                    foto: Image.asset('assets/tod.jpeg'),
                  ),
                  DoctorCard(
                    nombre: 'Dra. Lisa Cuddy',
                    especialidad: 'Endocrinología',
                    foto: Image.asset('assets/cuddy.jpeg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String nombre;
  final String especialidad;
  final Image foto;

  DoctorCard({
    required this.nombre,
    required this.especialidad,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: foto,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    especialidad,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Ver'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
