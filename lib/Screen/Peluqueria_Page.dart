import 'dart:math';

import 'package:flutter/material.dart';
import 'package:primer_parcial/Models/Peluqueria_Models.dart';
import 'package:primer_parcial/Providers/Peluqueria_Providers.dart';

class PeluqueriaPage extends StatefulWidget {
  const PeluqueriaPage({super.key});
  @override
  PeluqueriaPageState createState() => PeluqueriaPageState();
}

class PeluqueriaPageState extends State<PeluqueriaPage> {
  // Se declara el ScrollController para manejar el desplazamiento y detección del final de la lista
  late ScrollController _scrollController;

  final peluqueriaprovider = PeluqueriaProvider();
  late Future<List<PeluqueriaModels>> _listadoPeluquerias;

  // Variables para el manejo del scroll infinito
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    // Obtener los datos iniciales de las peluquerías
    _listadoPeluquerias = peluqueriaprovider.getPeluqueria();
    // Inicializar el ScrollController y asignar el _scrollListener
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  // Método que se ejecuta cuando el usuario desplaza la lista
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  // Método para cargar más datos cuando se llega al final de la lista
  void _loadMoreData() async {
    if (!isLoading && hasMore) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      // Agregar aquí la lógica para cargar más datos desde la fuente

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<Color> _randomColors = [
    const Color.fromARGB(255, 219, 245, 118),
    const Color.fromARGB(255, 106, 153, 192),
    const Color.fromARGB(255, 152, 214, 154),
    const Color.fromARGB(255, 100, 194, 188),
    const Color.fromARGB(255, 197, 118, 211),
    const Color.fromARGB(255, 214, 127, 252),
    // Agrega más colores según tu preferencia
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Peluqueria',
      home: Scaffold(
        appBar: AppBar(
          // Personalizacion del AppBar
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'API Peluqueria',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cut),
                  SizedBox(
                    width: 16,
                  )
                ],
              )
            ],
          ),
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 227, 55, 8),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 252, 204, 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(45),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
          ),
          child: FutureBuilder(
            future: _listadoPeluquerias,
            builder: ((context, snapshot) {
              // Se construye la interfaz según el estado del Future
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.hasData) {
                return ListView(
                  controller: _scrollController,
                  children: _listPeluquerias(snapshot.data!),
                );
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }

  // Método que convierte los datos de peluquerías en tarjetas
  List<Widget> _listPeluquerias(List<PeluqueriaModels> data) {
    List<Widget> peluquerias = [];

    final random = Random();

    for (var peluqueria in data) {
      final randomColor = _randomColors[random.nextInt(_randomColors.length)];
      peluquerias.add(
        Container(
          child: Card(
            color: randomColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 10,
            shadowColor: Colors.amberAccent,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(peluqueria.organizacion),
                  Text(peluqueria.direccionComercial),
                  Text(peluqueria.barrioComercial),
                  Text(peluqueria.municipioComercial),
                  Text(peluqueria.emailComercial),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Agregar indicador de carga al final de la lista
    if (isLoading) {
      peluquerias.add(
        const Center(child: CircularProgressIndicator()),
      );
    }

    return peluquerias;
  }
}
