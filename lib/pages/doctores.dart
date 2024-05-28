import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cita.dart';

class DoctoresPage extends StatefulWidget {

  DoctoresPage({super.key});

  @override
  State<DoctoresPage> createState() => _DoctoresPageState();
}

class _DoctoresPageState extends State<DoctoresPage> {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Alejandro',
      'specialty': 'Pediatria',
      'image':
          'https://th.bing.com/th/id/OIP.IVwf85npYYUcwRp4EIhqDgAAAA?w=137&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', // URL de la imagen del doctor
    },
    {
      'name': 'Dra. María',
      'specialty': 'Cardiología',
      'image':
          'https://th.bing.com/th/id/OIP.JODdTKvCi-ivu28zDmQk8gHaEj?w=289&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', // URL de la imagen del doctor
    },
    {
      'name': 'Dr. Juan',
      'specialty': 'Dermatología',
      'image':
          'https://www.crhoy.com/wp-content/uploads/2019/01/Captura-de-pantalla-2019-01-03-a-las-10.48.27.png',
    },
    {
      'name': 'Dr. Hector',
      'specialty': 'Pediatria',
      'image':
      'https://th.bing.com/th/id/OIP.IVwf85npYYUcwRp4EIhqDgAAAA?w=137&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', // URL de la imagen del doctor
    },
    {
      'name': 'Dra. Elena',
      'specialty': 'Cardiología',
      'image':
      'https://th.bing.com/th/id/OIP.JODdTKvCi-ivu28zDmQk8gHaEj?w=289&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', // URL de la imagen del doctor
    },
    {
      'name': 'Dr. Diego',
      'specialty': 'Dermatología',
      'image':
      'https://www.crhoy.com/wp-content/uploads/2019/01/Captura-de-pantalla-2019-01-03-a-las-10.48.27.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctores",
          style: GoogleFonts.openSans(
            color: const Color(0xFF0B8FAC),
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Buscar",
                filled: true,
                fillColor: Color(0x40D9D9D9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide.none,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Column(
                children: doctors.map((doctor) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(210, 235, 231, .3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              width: 150,
                              height: 190,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(doctor['image'] ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  doctor['name'] ?? '',
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Especialidad:",
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromRGBO(133, 133, 133, 1),
                                  ),
                                ),
                                Text(
                                  "${doctor['specialty']}",
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    color: const Color.fromRGBO(133, 133, 133, 1),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => cita(doctors: [
                                            {
                                              'name': doctor['nom_doctor'],
                                              'specialty': doctor['especialidad'],
                                              'consultation_fee': doctor['costo'],
                                              'foto': doctor['foto'],
                                            }
                                          ])),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(11, 143, 172, 1),
                                    minimumSize: const Size(20, 30),
                                  ),
                                  child: const Text(
                                    "Ver",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 15)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
