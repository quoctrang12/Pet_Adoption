import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pet_adopt/models/managers/auth_manager.dart';

import 'package:pet_adopt/const.dart';
import 'package:pet_adopt/pages/screens.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: Text(
            "Setting",
            style: poppins.copyWith(
              // color: black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 16,
                      color: blue,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Edit profile',
                      style: poppins.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
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
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserManagerScreen(),
                        ));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.storage,
                        size: 16,
                        color: blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Managers',
                        style: poppins.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
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
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.send,
                      size: 16,
                      color: blue,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Send comments',
                      style: poppins.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
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
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthManager>().logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: 16,
                        color: red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log out',
                        style: poppins.copyWith(
                          fontSize: 16,
                          color: red,
                        ),
                      ),
                      Spacer(),
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
              ),
              Divider(),
            ],
          ),
        ));
  }
}
