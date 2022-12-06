import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adopt/const.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pet_adopt/models/managers/owner_manager.dart';
import 'package:pet_adopt/models/managers/pets_manager.dart';
import 'package:pet_adopt/models/managers/auth_manager.dart';

import 'package:pet_adopt/pages/onboard/onboard_screen.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) {
            return AuthManager();
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, PetsManager>(
          create: (ctx) {
            return PetsManager();
          },
          update: (ctx, authManager, petsManager) {
            petsManager!.authToken = authManager.authToken;
            return petsManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, OwnerManager>(
          create: (ctx) => OwnerManager(),
          update: (ctx, authManager, ownersManager) {
            ownersManager!.authToken = authManager.authToken;
            return ownersManager;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Adopt',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: AnimatedSplashScreen(
          duration: 1500,
          splashIconSize: 200,
          splash: Column(
            children: [
              SvgPicture.asset(
                "assets/Paw_Print.svg",
                color: orange.shade400,
                height: 100,
              ),
              Text(
                "PET ADOPT",
                style: poppins.copyWith(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          nextScreen: const OnBoardPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: blue,
        ),
      ),
    );
  }
}
