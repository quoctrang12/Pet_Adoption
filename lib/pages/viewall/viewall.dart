import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pet_adopt/models/pets_model.dart';
import 'package:pet_adopt/models/managers/pets_manager.dart';

import 'package:pet_adopt/pages/detail/detail_screen.dart';
import 'package:pet_adopt/const.dart';

enum FilterOptions { favorites, all }

class ViewAllPage extends StatefulWidget {
  const ViewAllPage({Key? key}) : super(key: key);

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  var petsManager = PetsManager();
  final _showOnlyFavorites = ValueNotifier<bool>(false);

  late Future<void> _fetchPets;

  @override
  void initState() {
    super.initState();
    _fetchPets = context.read<PetsManager>().fetchPets(false);
  }

  @override
  Widget build(BuildContext context) {
    final pets = context.select<PetsManager, List<Pet>>((petsManager) =>
        _showOnlyFavorites.value ? petsManager.petIsfav : petsManager.pets);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: Row(
            children: [
              _showOnlyFavorites.value
                  ? Text(
                      "Only Favorites",
                      style: poppins.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Text(
                      "View All",
                      style: poppins.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const Spacer(),
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(() {
                    if (selectedValue == FilterOptions.favorites) {
                      _showOnlyFavorites.value = true;
                    } else {
                      _showOnlyFavorites.value = false;
                    }
                  });
                },
                position: PopupMenuPosition.under,
                icon: const Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                    value: FilterOptions.favorites,
                    child: Text('Only Favorites'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.all,
                    child: Text('View All'),
                  )
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _fetchPets,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ValueListenableBuilder<bool>(
                    valueListenable: _showOnlyFavorites,
                    builder: (context, onlyFavorites, child) {
                      return GridView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: pets.length,
                          itemBuilder: (ctx, i) =>
                              PetGridTile(context, pets[i]),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ));
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget PetGridTile(BuildContext context, Pet pet) {
    Color color = colorRandom[math.Random().nextInt(4)];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              pet: pet,
              color: color,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .6,
          color: color.withOpacity(.6),
          child: Stack(
            children: [
              Positioned(
                bottom: -10,
                right: -10,
                width: 100,
                height: 100,
                child: Transform.rotate(
                  angle: 12,
                  child: SvgPicture.asset(
                    'assets/Paw_Print.svg',
                    color: color,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: -25,
                width: 100,
                height: 100,
                child: Transform.rotate(
                  angle: -11.5,
                  child: SvgPicture.asset(
                    'assets/Paw_Print.svg',
                    color: color,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: 20,
                child: Image.asset(
                  pet.image,
                  height: MediaQuery.of(context).size.height * .15,
                ),
              ),
              Container(
                color: color.withOpacity(.4),
                height: MediaQuery.of(context).size.height * .1,
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet.name,
                            style: poppins.copyWith(
                                fontSize: 18,
                                color: black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: blue,
                                size: 14,
                              ),
                              Text(
                                'Distance (${pet.distance} km)',
                                style: poppins.copyWith(
                                    fontSize: 12, color: black.withOpacity(.6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      width: 30,
                      height: 30,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: white),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: pet.isFavoriteListenable,
                        builder: (ctx, isFavorite, child) => IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            size: 18,
                            pet.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            color: pet.isFavorite ? red : black.withOpacity(.6),
                          ),
                          onPressed: () {
                            ctx.read<PetsManager>().toggleFavoriteStatus(pet);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
