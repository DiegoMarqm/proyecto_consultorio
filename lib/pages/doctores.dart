import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../db/medicos.dart';
import 'cita.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MedicosDB.conecctMedicos();
}

class DoctoresPage extends StatefulWidget {
  const DoctoresPage({super.key});

  @override
  State<DoctoresPage> createState() => _DoctoresPageState();
}

class _DoctoresPageState extends State<DoctoresPage> {
  List<Map<String, dynamic>> medicos = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMedicos();
    _searchController.addListener(_loadMedicos);
  }

  _loadMedicos() async {
    medicos = await MedicosDB.getMedicos();

    String searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      medicos = medicos.where((medico) {
        String nombreDoctor = medico['nom_doctor'].toLowerCase();
        String especialidadDoctor = medico['especialidad'].toLowerCase();
        return nombreDoctor.contains(searchText.toLowerCase()) || especialidadDoctor.contains(searchText.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

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
             TextField(
              controller: _searchController,
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
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Column(
                children: medicos.map((doctor) {
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
                                  image: NetworkImage(doctor['foto'] ?? ''),
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
                                  doctor['nom_doctor'] ?? '',
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
                                  "${doctor['especialidad']}",
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
                                          builder: (context) => Cita(doctors: [
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
