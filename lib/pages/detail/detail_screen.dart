import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:provider/provider.dart';

import 'package:pet_adopt/models/owner_model.dart';
import 'package:pet_adopt/models/pets_model.dart';

import 'package:pet_adopt/models/managers/pets_manager.dart';
import 'package:pet_adopt/models/managers/owner_manager.dart';

import 'package:pet_adopt/const.dart';

class DetailPage extends StatefulWidget {
  final Pet pet;
  final dynamic color;
  const DetailPage({Key? key, required this.pet, required this.color})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    final Owner owner = context
        .read<OwnerManager>()
        .owners
        .firstWhere((element) => element.creatorId == widget.pet.creatorId);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // widget.pet.color
                  color: widget.color.withOpacity(.5),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -60,
                      top: 30,
                      child: Transform.rotate(
                        angle: -11.5,
                        child: SvgPicture.asset(
                          'assets/Paw_Print.svg',
                          color: widget.color,
                          height: 300,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -60,
                      bottom: -60,
                      child: Transform.rotate(
                        angle: 12,
                        child: SvgPicture.asset(
                          'assets/Paw_Print.svg',
                          color: widget.color,
                          height: 300,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: MediaQuery.of(context).size.width * .2,
                      child: Image.asset(
                        widget.pet.image,
                        height: MediaQuery.of(context).size.height * .4,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white),
                        child: const Icon(
                          Icons.more_horiz,
                          color: black,
                        ),
                      ),
                    ]),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .55,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.pet.name,
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
                                          size: 16,
                                        ),
                                        Text(
                                          widget.pet.location,
                                          style: poppins.copyWith(
                                            color: black.withOpacity(.6),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          color: widget.pet.isFavorite
                                              ? red
                                              : black.withOpacity(.6),
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ]),
                                child: ValueListenableBuilder<bool>(
                                  valueListenable:
                                      widget.pet.isFavoriteListenable,
                                  builder: (ctx, isFavorite, child) =>
                                      IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(
                                      size: 24,
                                      widget.pet.isFavorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline_rounded,
                                      color: widget.pet.isFavorite
                                          ? red
                                          : black.withOpacity(.6),
                                    ),
                                    onPressed: () {
                                      ctx
                                          .read<PetsManager>()
                                          .toggleFavoriteStatus(widget.pet);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Detailitem(
                                color: green,
                                detail: widget.pet.sex,
                                detail_: 'Sex',
                              ),
                              Detailitem(
                                color: orange,
                                detail: '${widget.pet.age} Years',
                                detail_: 'Age',
                              ),
                              Detailitem(
                                color: blue,
                                detail: '${widget.pet.weight} Kg',
                                detail_: 'Weight',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: red,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          owner.image,
                                          ),
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // widget.pet.owner.name,
                                      owner.name,
                                      style: poppins.copyWith(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${widget.pet.name} Owner',
                                      style: poppins.copyWith(
                                        fontSize: 14,
                                        color: black.withOpacity(.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: blue.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.chat_outlined,
                                  color: blue,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: red.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.phone_outlined,
                                  color: red,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ReadMoreText(
                            widget.pet.description,
                            textAlign: TextAlign.justify,
                            trimCollapsedText: 'See More',
                            colorClickableText: orange,
                            trimLength: 100,
                            trimMode: TrimMode.Length,
                            style: poppins,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      color: blue,
                                      spreadRadius: 0,
                                      blurRadius: 10)
                                ],
                                color: blue),
                            child: Center(
                                child: Text('Adopt Me',
                                    style: poppins.copyWith(
                                        color: white, fontSize: 14))),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Detailitem extends StatelessWidget {
  final Color color;
  final String detail, detail_;
  const Detailitem({
    Key? key,
    required this.color,
    required this.detail,
    required this.detail_,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 3 - 25,
          decoration: BoxDecoration(
            color: color.withOpacity(.6),
          ),
          child: Stack(children: [
            Positioned(
              bottom: -10,
              right: -5,
              child: Transform.rotate(
                angle: 12,
                child: SvgPicture.asset(
                  'assets/Paw_Print.svg',
                  color: color,
                  height: 60,
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 80,
          width: MediaQuery.of(context).size.width / 3 - 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                detail,
                style: poppins.copyWith(
                    fontSize: 16, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                detail_,
                style: poppins.copyWith(
                    fontSize: 14, color: black.withOpacity(.6)),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
