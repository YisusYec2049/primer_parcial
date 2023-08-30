import 'dart:convert';

PeluqueriaModels peluqeriaModelsFromJson(String str) =>
    PeluqueriaModels.fromJson(json.decode(str));

String peluqeriaModelsToJson(PeluqueriaModels data) =>
    json.encode(data.toJson());

class Peluquerias {
  List<PeluqueriaModels> items = [];
  Peluquerias(); // Cambia a constructor sin parámetros
  Peluquerias.fromJsonList(jsonList) {
    if (jsonList == null) return;
    for (var elemento in jsonList) {
      final peluqueria = PeluqueriaModels.fromJson(elemento);
      items.add(peluqueria);
    }
  }
}

class PeluqueriaModels {
  final String organizacion;
  final String razonSocial;
  final String direccionComercial;
  final String barrioComercial;
  final String municipioComercial;
  final String emailComercial;
  final String ciiu1;
  final String actividad;
  final String camaraDePropietario;
  final String nombreDePropietario;
  final String emailPropietario;

  PeluqueriaModels({
    required this.organizacion,
    required this.razonSocial,
    required this.direccionComercial,
    required this.barrioComercial,
    required this.municipioComercial,
    required this.emailComercial,
    required this.ciiu1,
    required this.actividad,
    required this.camaraDePropietario,
    required this.nombreDePropietario,
    required this.emailPropietario,
  });

  factory PeluqueriaModels.fromJson(Map<String, dynamic> json) =>
      PeluqueriaModels(
        organizacion: json["organizacion"],
        razonSocial: json["razon_social"],
        direccionComercial: json["direccion_comercial"],
        barrioComercial: json["barrio_comercial"],
        municipioComercial: json["municipio_comercial"],
        emailComercial: json["email_comercial"],
        ciiu1: json["ciiu_1"],
        actividad: json["actividad"],
        camaraDePropietario: json["camara_de_propietario"],
        nombreDePropietario: json["nombre_de_propietario"],
        emailPropietario: json["email_propietario"],
      );

  Map<String, dynamic> toJson() => {
        "organizacion": organizacion,
        "razon_social": razonSocial,
        "direccion_comercial": direccionComercial,
        "barrio_comercial": barrioComercial,
        "municipio_comercial": municipioComercial,
        "email_comercial": emailComercial,
        "ciiu_1": ciiu1,
        "actividad": actividad,
        "camara_de_propietario": camaraDePropietario,
        "nombre_de_propietario": nombreDePropietario,
        "email_propietario": emailPropietario,
      };
}
