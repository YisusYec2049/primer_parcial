import 'package:flutter/material.dart';
import 'package:primer_parcial/Models/Peluqueria_Models.dart';
import 'package:primer_parcial/Providers/Peluqueria_Providers.dart';

class PeluqueriaPage extends StatefulWidget {
  const PeluqueriaPage({super.key});
  @override
  PeluqueriaPageState createState() => PeluqueriaPageState();
}

class PeluqueriaPageState extends State<PeluqueriaPage> {
  final peluqueriaprovider = PeluqueriaProvider();
  late Future<List<PeluqueriaModels>> _listadoPeluquerias;

  @override
  void initState() {
    super.initState();
    _listadoPeluquerias = peluqueriaprovider.getPeluqueria();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Gif API",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _listadoPeluquerias,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.hasData) {
                return ListView(children: _listPeluquerias(snapshot.data!));
              }
              return const CircularProgressIndicator();
            })),
      ),
    );
  }

  List<Widget> _listPeluquerias(List<PeluqueriaModels> data) {
    List<Widget> peluquerias = [];

    for (var peluqueria in data) {
      peluquerias.add(Card(
        child: Column(
          children: [
            Text(peluqueria.organizacion),
            Text(peluqueria.razonSocial),
            Text(peluqueria.direccionComercial),
            Text(peluqueria.barrioComercial),
            Text(peluqueria.municipioComercial),
            Text(peluqueria.emailComercial),
            Text(peluqueria.ciiu1),
          ],
        ),
      ));
    }
    return peluquerias;
  }
}
