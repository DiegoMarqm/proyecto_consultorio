import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/db/medicos.dart';
import 'package:proyecto_consultorio/pages/cita.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MedicosDB.conecctMedicos();
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> medicos = [];
  List<Map<String, dynamic>> medicosAle = [];
  @override
  void initState() {
    super.initState();
    _loadMedicos();
  }

  _loadMedicos() async {
    medicos = await MedicosDB.getMedicos();
    medicosAle = await MedicosDB.getMedicosAleatorios();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> especialidades = medicos.map((doctor) => doctor['especialidad'] as String).toSet().toList()..sort((a, b) => a.compareTo(b));

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
              padding: const EdgeInsets.only(left: 15, top: 30, right: 10, bottom: 5),
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
              itemCount: especialidades.length,
              itemBuilder: (context, index) {
                final especialidad = especialidades[index];
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
                              especialidad,
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
                      const EdgeInsets.only(left: 15, top: 30, right: 10, bottom: 5),
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
            children: medicosAle.map((doc) {
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
                              image: NetworkImage(doc['foto'] ?? ''),
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
                              doc['nom_doctor'] ?? '',
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
                            Text("${doc['especialidad']}",
                              style: GoogleFonts.openSans(
                                fontSize: 17,
                                color: const Color.fromRGBO(133, 133, 133, 1),
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