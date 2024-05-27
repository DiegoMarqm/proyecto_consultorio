import 'package:flutter/material.dart';

import 'cita.dart';

class DoctoresPage extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'nombre': 'Dr. Gregory House',
      'especialidad': 'Nefrología e infectología',
      'foto': const AssetImage('assets/house.jpg'),
    },
    {
      'nombre': 'Dra. Cameron',
      'especialidad': 'Inmunología',
      'foto': const AssetImage('assets/cameron.jpg'),
    },
    {
      'nombre': 'Dr. Chase',
      'especialidad': 'Cardiología y cuidados intensivos',
      'foto': const AssetImage('assets/chasse.jpg'),
    },
    {
      'nombre': 'Dr. Foreman',
      'especialidad': 'Neurología',
      'foto': const AssetImage('assets/Foreman.jpg'),
    },
    {
      'nombre': 'Dr. James Wilson',
      'especialidad': 'Oncología',
      'foto': const AssetImage('assets/james.jpeg'),
    },
    {
      'nombre': 'Dr. Christopher Taub',
      'especialidad': 'Cirujano Plástico y Reconstructivo',
      'foto': const AssetImage('assets/tod.jpeg'),
    },
    {
      'nombre': 'Dra. Lisa Cuddy',
      'especialidad': 'Endocrinología',
      'foto': const AssetImage('assets/cuddy.jpeg'),
    },
  ];

  DoctoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctores',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Buscar Doctor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
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

  const DoctorCard({super.key,
    required this.nombre,
    required this.especialidad,
    required this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
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
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    especialidad,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cita()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('Ver'),
            ),
          ],
        ),
      ),
    );
  }
}