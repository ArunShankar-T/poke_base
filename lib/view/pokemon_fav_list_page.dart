import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_base/controller/pokemon_fav_controller.dart';
import 'package:poke_base/utils/view_utils.dart';

import '../utils/app_strings.dart';

class PokemonFavListPage extends StatelessWidget {
  const PokemonFavListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pokemonFavController = Get.put(PokemonFavController());
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 80),
      Stack(children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(Icons.arrow_back, size: 30),
              )),
        ),
        const Expanded(
          child: Center(
            child: Text(AppStrings.FAVORITE_POKEMON,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ),
        )
      ]),
      const SizedBox(height: 20),
      Expanded(child: Obx(() {
        var favList = _pokemonFavController.favPokemonList;
        if (favList.isEmpty) {
          return Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/connection_error.png',
                      width: 60, height: 60),
                  const SizedBox(height: 20),
                  const Text(AppStrings.API_ERROR)
                ]),
          );
        } else {
          var listSize = _pokemonFavController.favPokemonList.length;
          return GridView.builder(
            itemCount: listSize,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              var pokemonItem = _pokemonFavController.favPokemonList[index];
              return Card(
                  color: Colors.redAccent,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Stack(children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(pokemonItem.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(75),
                                          bottomLeft: Radius.circular(75))),
                                  child: Image.memory(
                                    ViewUtils.stringToBytes(
                                        pokemonItem.imageBase64),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ]),
                      GestureDetector(
                        onTap: () {
                          _pokemonFavController
                              .removeFavPokemon(pokemonItem.id);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(boxShadow: const [
                              BoxShadow(color: Colors.black12)
                            ], borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                                child: Icon(Icons.favorite_outlined, size: 17)),
                          ),
                        ),
                      )
                    ]),
                  ));
            },
          );
        }
      })),
    ]));
  }
}
