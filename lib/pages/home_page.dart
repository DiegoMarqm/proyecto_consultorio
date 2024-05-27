import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/cita.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {"text": "Pediatría"},
      {"text": "Traumatología"},
      {"text": "Ginecología"},
    ];
    List<Map<String, dynamic>> doctores = [
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
        'name': 'Dr. Juan Pérez',
        'specialty': 'Dermatología',
        'image':
            'https://www.crhoy.com/wp-content/uploads/2019/01/Captura-de-pantalla-2019-01-03-a-las-10.48.27.png',
      },
      // Puedes agregar más doctores si lo deseas
    ];
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
          child: TextField(
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
              floatingLabelBehavior: FloatingLabelBehavior.never, // Evita que el texto de la etiqueta aparezca cuando se enfoca el TextField
            ),
          ),

        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 15, top: 30, right: 10, bottom: 5),
              child: Text(
                "Especialidades",
                style: GoogleFonts.openSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 150,
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(int.parse("0xFF7BC1B7")),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              item["text"]!,
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 30, right: 10, bottom: 5),
                  child: Text(
                    "Doctores",
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctoresPage()
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 35, right: 15, bottom: 5),
                child: Text(
                  "Más",
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            children: doctores.map((doctor) {
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
                                color: Color.fromRGBO(133, 133, 133, 1),
                              ),
                            ),
                            Text("${doctor['specialty']}",
                              style: GoogleFonts.openSans(
                                fontSize: 17,
                                color: Color.fromRGBO(133, 133, 133, 1),
                              ),),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => cita()),
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
    );
  }
}