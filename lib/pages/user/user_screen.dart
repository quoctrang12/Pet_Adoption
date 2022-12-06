import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pet_adopt/models/managers/owner_manager.dart';
import 'package:pet_adopt/models/managers/auth_manager.dart';

import 'package:pet_adopt/const.dart';
import 'package:pet_adopt/pages/screens.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  Future<void> _refreshOwner(BuildContext context) async {
    await context.read<OwnerManager>().fetchOwners(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: Text(
            "User",
            style: poppins.copyWith(
              //color: black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: _refreshOwner(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshOwner(context),
              child: Consumer<OwnerManager>(
                builder: (context, ownerManager, child) =>
                    SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 1.1,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: ownerManager
                                      .owners.first.image.isNotEmpty
                                  ? BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          colorRandom[math.Random().nextInt(4)],
                                      image: DecorationImage(
                                        image: AssetImage(
                                            ownerManager.owners.first.image),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : BoxDecoration(),
                              child: ownerManager.owners.first.image.isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: blue,
                                      child: Text(
                                        ownerManager.owners.first.name[0]
                                            .toUpperCase(),
                                        style: poppins.copyWith(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          Text(
                            ownerManager.owners.first.name,
                            style: poppins.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text('Informations',
                                  style: poppins.copyWith(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: -5.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: blue,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Phone: ',
                                      style: poppins.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          ownerManager.owners.first.phone,
                                          style: poppins.copyWith(
                                            color: black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: blue,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Email: ',
                                      style: poppins.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          ownerManager.owners.first.email,
                                          style: poppins.copyWith(
                                            color: black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: blue,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Address: ',
                                      style: poppins.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          // 'Xuan Khanh, Ninh Kieu, Can Tho',
                                          ownerManager.owners.first.address,
                                          style: poppins.copyWith(
                                            color: black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text('Options',
                                  style: poppins.copyWith(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: -5.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UserEditProfileScreen(
                                                  owner: ownerManager
                                                      .owners.first),
                                        ));
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: blue,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Edit profile',
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Container(
                                            padding: const EdgeInsets.all(3),
                                            child: const Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              size: 14,
                                              color: blue,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UserManagerScreen(),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    color: white,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          LineIcons.paw,
                                          size: 22,
                                          color: blue,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'My Pets',
                                          style: poppins.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Container(
                                            padding: const EdgeInsets.all(3),
                                            child: const Icon(
                                              Icons
                                                  .keyboard_arrow_right_rounded,
                                              size: 14,
                                              color: blue,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.send,
                                        size: 16,
                                        color: blue,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Send comments',
                                        style: poppins.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Container(
                                          padding: const EdgeInsets.all(3),
                                          child: const Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            size: 14,
                                            color: blue,
                                          ))
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 1.0,
                                  spreadRadius: -1.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                color: Colors.grey.shade300,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<AuthManager>().logout();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.arrowRightFromBracket,
                                        size: 16,
                                        color: black,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Log out',
                                        style: poppins.copyWith(
                                            fontSize: 16,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
