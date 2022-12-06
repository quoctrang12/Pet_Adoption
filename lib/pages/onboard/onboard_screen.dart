import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:pet_adopt/models/onboards_model.dart';
import 'package:pet_adopt/models/managers/auth_manager.dart';

import 'package:pet_adopt/const.dart';
import 'package:pet_adopt/pages/screens.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
        builder: (ctx, authManager, child) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .75,
                      color: white,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount: onBoardData.length,
                        itemBuilder: (context, index) => OnBoardContent(
                          onBoard: onBoardData[index],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => authManager.isAuth
                                  ? const HomeScreen()
                                  : FutureBuilder(
                                      future: authManager.tryAutoLogin(),
                                      builder: (context, snapshot) {
                                        return snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? const SplashScreen()
                                            : const LoginScreen();
                                      },
                                    ),
                            ),
                            (route) => false);
                      },
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .6,
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    color: blue,
                                    spreadRadius: 0,
                                    blurRadius: 5)
                              ]),
                          child: Center(
                            child: Text(
                              currentPage == onBoardData.length - 1
                                  ? 'Get Started'
                                  : 'Continue',
                              style:
                                  poppins.copyWith(color: white, fontSize: 16),
                            ),
                          )),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          onBoardData.length,
                          (index) => indicator(index: index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: currentPage == index ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentPage == index ? orange : black.withOpacity(.6),
      ),
    );
  }
}

class OnBoardContent extends StatelessWidget {
  final OnBoards onBoard;
  const OnBoardContent({Key? key, required this.onBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    color: orange.shade200,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: -40,
                          height: 150,
                          width: 150,
                          child: Transform.rotate(
                            angle: -11.5,
                            child: SvgPicture.asset(
                              "assets/Paw_Print.svg",
                              color: orange.shade400,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          right: -30,
                          height: 150,
                          width: 150,
                          child: Transform.rotate(
                            angle: 12,
                            child: SvgPicture.asset(
                              "assets/Paw_Print.svg",
                              color: orange.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 60,
                child: Image.asset(
                  onBoard.image,
                  height: 350,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text.rich(
          TextSpan(
              style: poppins.copyWith(
                  height: 1.2,
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
              children: [
                TextSpan(text: 'Find Your ', style: poppins),
                TextSpan(text: 'Dream\n', style: poppins.copyWith(color: blue)),
                TextSpan(text: 'Pet Here', style: poppins),
              ]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          onBoard.text,
          textAlign: TextAlign.center,
          style: poppins.copyWith(color: black.withOpacity(.6)),
        )
      ],
    );
  }
}
