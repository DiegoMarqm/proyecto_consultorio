import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/db/medicos.dart';
import 'package:proyecto_consultorio/pages/cita.dart';
import 'package:proyecto_consultorio/pages/doctores.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que los widgets de Flutter estén inicializados antes de ejecutar cualquier código
  await MedicosDB.conecctMedicos(); //Conecta a la base de datos de médicos
  runApp(const HomePage()); //Ejecuta la app
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> medicos = []; //lista de medicos
  List<Map<String, dynamic>> medicosAle = []; //medicos aleatorios
  final TextEditingController busquedaController =
      TextEditingController(); //controla el texto de ls busquedas
  bool isLoading = true;

  @override
  void initState() {
    //Inicializa la carga de médicos y configura un listener para el campo de búsqueda.
    super.initState();
    _loadMedicos();
    busquedaController.addListener(_loadMedicos);
  }

  _loadMedicos() async {
    //Método que carga la lista de médicos y la filtra según el texto de búsqueda. Si no hay texto de búsqueda, muestra médicos aleatorios.
    medicos = await MedicosDB.getMedicos();
    medicosAle = await MedicosDB.getMedicosAleatorios();
    isLoading = true;

    String busquedaText = busquedaController.text;

    if (busquedaText.isNotEmpty) {
      medicos = medicos.where((doctor) {
        String nombreDoctor = doctor['nom_doctor'].toLowerCase();
        String especialidadDoctor = doctor['especialidad'].toLowerCase();
        return nombreDoctor.contains(busquedaText.toLowerCase()) ||
            especialidadDoctor.contains(busquedaText.toLowerCase());
      }).toList();
    } else {
      setState(() {
        medicos = medicosAle;
      });
    }
    setState(() {
      isLoading =
          false; // Oculta la animación de carga al finalizar la carga de médicos
    });
  }

  @override
  Widget build(BuildContext context) {
    //Lista de especialidades únicas de los médicos, ordenada alfabéticamente.
    List<String> especialidades = medicos
        .map((doctor) => doctor['especialidad'] as String)
        .toSet()
        .toList()
      ..sort((a, b) => a.compareTo(b));

    return ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
          child: TextField(
            controller: busquedaController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: "Buscar",
              filled: true,
              fillColor: Color(0x40D9D9D9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none,
              ),
              floatingLabelBehavior: FloatingLabelBehavior
                  .never, // Evita que el texto de la etiqueta aparezca cuando se enfoca el TextField
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 30, right: 10, bottom: 5),
            child: Text(
              "Especialidades",
              style: GoogleFonts.openSans(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
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
                padding: const EdgeInsets.only(
                    left: 15, top: 30, right: 10, bottom: 5),
                child: Text(
                  "Doctores",
                  style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctoresPage()),
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
            children: isLoading
                ? [CircularProgressIndicator()]
                : medicos.map((doc) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      color: const Color.fromRGBO(
                                          133, 133, 133, 1),
                                    ),
                                  ),
                                  Text(
                                    "${doc['especialidad']}",
                                    style: GoogleFonts.openSans(
                                      fontSize: 17,
                                      color: const Color.fromRGBO(
                                          133, 133, 133, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Cita(doctors: [
                                                  {
                                                    'name': doc['nom_doctor'],
                                                    'specialty':
                                                        doc['especialidad'],
                                                    'consultation_fee':
                                                        doc['costo'],
                                                    'foto': doc['foto'],
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
    );
  }
}
