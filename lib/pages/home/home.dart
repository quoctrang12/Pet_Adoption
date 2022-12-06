import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adopt/models/managers/owner_manager.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:pet_adopt/models/pets_model.dart';
import 'package:pet_adopt/models/managers/pets_manager.dart';

import 'package:pet_adopt/const.dart';
import 'package:pet_adopt/pages/screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ['Cats', 'Dogs', 'Hamsters'];
  String category = 'Cats';
  int selectedPage = 0;
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.chat_outlined,
    Icons.person
  ];
  late Future<void> _fetchPets;
  @override
  void initState() {
    super.initState();
    _fetchPets = context.read<PetsManager>().fetchPets(false);
    context.read<OwnerManager>().fetchOwners();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: _fetchPets,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var listPet = context.read<PetsManager>().getListPet(category);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Location',
                                        style: poppins.copyWith(
                                          fontSize: 14,
                                          color: black.withOpacity(.6),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: blue,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Can Tho, ',
                                          style: poppins.copyWith(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: black),
                                        ),
                                        TextSpan(
                                          text: 'Ninh Kieu',
                                          style: poppins.copyWith(
                                              fontSize: 24, color: black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SearchScreen(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                    height: 7,
                                    width: 7,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: red,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.notifications_outlined),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            color: blue.withOpacity(.6),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -35,
                                  right: -30,
                                  width: 150,
                                  height: 150,
                                  child: Transform.rotate(
                                    angle: 12,
                                    child: SvgPicture.asset(
                                      'assets/Paw_Print.svg',
                                      color: blue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -35,
                                  left: -30,
                                  width: 150,
                                  height: 150,
                                  child: Transform.rotate(
                                    angle: -12,
                                    child: SvgPicture.asset(
                                      'assets/Paw_Print.svg',
                                      color: blue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -40,
                                  right: 100,
                                  width: 150,
                                  height: 150,
                                  child: Transform.rotate(
                                    angle: -60,
                                    child: SvgPicture.asset(
                                      'assets/Paw_Print.svg',
                                      color: blue,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 5,
                                  height: 135,
                                  child: Image.asset('assets/cats/cat2.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Join Our Animal\nLovers Community',
                                        style: poppins.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: orange),
                                        child: Text(
                                          'Join Us',
                                          style: poppins.copyWith(
                                              color: white, fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: poppins.copyWith(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'View All',
                                  style: poppins.copyWith(
                                    color: orange,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: orange),
                                  child: const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 14,
                                      color: white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: const BoxDecoration(color: white),
                                child: const Icon(Icons.tune_rounded)),
                            ...List.generate(
                              categories.length,
                              (index) => Padding(
                                padding: index == 0
                                    ? const EdgeInsets.symmetric(horizontal: 20)
                                    : const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      category = categories[index];
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: categories[index] == category
                                          ? blue
                                          : white,
                                      boxShadow: [
                                        categories[index] == category
                                            ? const BoxShadow(
                                                offset: Offset(0, 5),
                                                color: blue,
                                                spreadRadius: 0,
                                                blurRadius: 10)
                                            : const BoxShadow(color: white)
                                      ],
                                    ),
                                    child: Text(
                                      categories[index],
                                      style: poppins.copyWith(
                                          color: categories[index] == category
                                              ? white
                                              : black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              'Adopt Pet',
                              style: poppins.copyWith(
                                color: black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'View All',
                                  style: poppins.copyWith(
                                    color: orange,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ViewAllPage(
                                            // pet: petsManager
                                            //     .getListPet(category)[index]),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: orange),
                                    child: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        size: 14,
                                        color: white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            listPet.length,
                            (index) => Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    )
                                  : const EdgeInsets.only(
                                      right: 20,
                                    ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        pet: listPet[index],
                                        color: colorRandom[
                                            math.Random().nextInt(4)],
                                      ),
                                    ),
                                  );
                                },
                                child: PetItem(context, listPet[index],
                                    colorRandom[math.Random().nextInt(4)]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget PetItem(BuildContext context, Pet pet, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: MediaQuery.of(context).size.height * .35,
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
                height: MediaQuery.of(context).size.height * .25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
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
                              fontSize: 24,
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
                                  fontSize: 12, color: black.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: white),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: pet.isFavoriteListenable,
                      builder: (ctx, isFavorite, child) => IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          size: 24,
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
    );
  }
}
