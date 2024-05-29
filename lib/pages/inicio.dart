import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_consultorio/pages/home_page.dart';
import 'package:proyecto_consultorio/pages/history_page.dart';
import 'package:proyecto_consultorio/pages/perfil.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 30),
            child: Text(
              "SanaTec",
              style: GoogleFonts.openSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(11, 143, 172, 1),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              type: MaterialType.transparency,
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color.fromRGBO(11, 143, 172, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                tabs: const [
                  Tab(icon: Icon(Icons.home_outlined)),
                  Tab(icon: Icon(Icons.access_time)),
                  Tab(icon: Icon(Icons.perm_identity_rounded)),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const HomePage(),
                const HistoryPage(),
                perfil(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
