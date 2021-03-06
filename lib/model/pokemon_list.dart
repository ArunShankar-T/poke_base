import 'package:flutter/foundation.dart';

class PokemonList {
  String? nextRequestUrl;
  List<Pokemon> pokemon = <Pokemon>[];

  PokemonList({this.nextRequestUrl, required this.pokemon});

  PokemonList.fromJson(Map<String, dynamic> json) {
    nextRequestUrl = json['next'];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        pokemon.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = nextRequestUrl;
    data['results'] = pokemon.map((v) => v.toJson()).toList();
    return data;
  }
}

class Pokemon {
  String? name;
  String? url;

  Pokemon({this.name, this.url});

  int pokemonId = 0;
  bool isFav = false;

  Pokemon.fromJson(Map<String, dynamic> json) {
    try {
      name = json['name'];
      url = json['url'];
      pokemonId = int.parse(url?.split("/")[6] ?? "0");
    } catch (e) {
      debugPrint("$e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
