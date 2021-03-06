import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poke_base/model/pokemon_detail.dart';
import 'package:poke_base/services/remote_services.dart';

class PokemonDetailController extends GetxController {
  var pokemonDetails = PokemonDetails().obs;
  var isLoading = true.obs;
  var isError = false.obs;

  /// Fetches the pokemon details from the api by using [pokemonId].
  /// Returns the [PokemonDetails] from the api.
  fetchPokemonDetails(int pokemonId) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));
      //Fetch from Api
      pokemonDetails.value =
          await RemoteServices().fetchPokemonDetails(pokemonId);
      if (isError.value) {
        isError(false);
      }
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  /// Converts json string into [PokemonDetails] object [pokemonDetailJson].
  setPokemonDetails(String pokemonDetailJson) {
    try {
      pokemonDetails.value =
          PokemonDetails.fromJson(json.decode(pokemonDetailJson));
      if (isError.value) {
        isError(false);
      }
    } catch (e) {
      debugPrint("$e");
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
