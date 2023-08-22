import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class House {
  final String? id;
  final String name;
  final String address;
  final String imageUrl;

  House({required this.id, required this.name, required this.address, required this.imageUrl});

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      imageUrl: json['images'],
    );
  }

  static Future<List<House>> fetchHouses() async {
    final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/https://f6c0-181-143-170-114.ngrok-free.app/properties'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((house) => House.fromJson(house)).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }

  static Future<List<House>> generateRecommended() async {
    List<House> houses = await fetchHouses();
    // Aquí puedes filtrar o seleccionar las casas que quieras recomendar.
    // Por ahora, simplemente devolveré las dos primeras propiedades como recomendadas.
    return houses.take(2).toList();
  }

  static Future<List<House>> generateBestOffer() async {
    List<House> houses = await fetchHouses();
    // Aquí puedes filtrar o seleccionar las casas que quieras ofrecer como las mejores ofertas.
    // Por ahora, simplemente devolveré las propiedades en las posiciones 2 y 3 como las mejores ofertas.
    return houses.skip(2).toList();
  }
}
