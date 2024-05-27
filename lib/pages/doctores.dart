import 'package:flutter/material.dart';

class doctores extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'nombre': 'Dr. Gregory House',
      'especialidad': 'Nefrología e infectología',
      'foto': AssetImage('assets/house.jpg'),
    },
    {
      'nombre': 'Dra. Cameron',
      'especialidad': 'Inmunología',
      'foto': AssetImage('assets/cameron.jpg'),
    },
    {
      'nombre': 'Dr. Chase',
      'especialidad': 'Cardiología y cuidados intensivos',
      'foto': AssetImage('assets/chasse.jpg'),
    },
    {
      'nombre': 'Dr. Foreman',
      'especialidad': 'Neurología',
      'foto': AssetImage('assets/Foreman.jpg'),
    },
    {
      'nombre': 'Dr. James Wilson',
      'especialidad': 'Oncología',
      'foto': AssetImage('assets/james.jpeg'),
    },
    {
      'nombre': 'Dr. Christopher Taub',
      'especialidad': 'Cirujano Plástico y Reconstructivo',
      'foto': AssetImage('assets/tod.jpeg'),
    },
    {
      'nombre': 'Dra. Lisa Cuddy',
      'especialidad': 'Endocrinología',
      'foto': AssetImage('assets/cuddy.jpeg'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctores',
          style: TextStyle(color: Colors.blue),
        ),
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
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    nombre: doctor['nombre'],
                    especialidad: doctor['especialidad'],
                    foto: doctor['foto'],
                  );
                },
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
  final ImageProvider<Object> foto;

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
                child: Image(
                  image: foto,
                  fit: BoxFit.cover,
                ),
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
                // Acción al presionar el botón "Ver"
              },
              child: Text('Ver'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}