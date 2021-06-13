import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/screens/AuthScreen.dart';
import 'package:forest_island/screens/CatalogScreen.dart';
import 'package:forest_island/screens/ContactsScreen.dart';
import 'package:forest_island/screens/ListScreen.dart';
import 'package:forest_island/screens/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forest_island/screens/RegistrationScreen.dart';
import 'package:forest_island/screens/SignInPage.dart';
import 'package:forest_island/widgets/authentication_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'screens/AuthScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: OverlaySupport(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.white),
              ),
              fontFamily: 'Montserrat',
              brightness: Brightness.dark,
              accentColor: Colors.blue),
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.black),
              ),
              fontFamily: 'Montserrat',
              brightness: Brightness.light),
          title: 'Welcome to Flutter',
          home: MainScreen(),
          routes: {
            '/auth': (BuildContext context) => AuthScreen(),
            '/card': (BuildContext context) => ListScreen(),
            '/home': (BuildContext context) => MainScreen(),
            '/registration': (BuildContext context) => RegistrationScreen(),
            '/signin': (BuildContext context) => SignInPage(),
            '/authWrapper': (BuildContext context) => AuthenticationWrapper(),
            '/contacts': (BuildContext context) => ContactsScreen(),
            '/catalog': (BuildContext context) => HomeScreen()
          },
          initialRoute: '/auth',
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    FirebaseAuth auth = FirebaseAuth.instance;

    if (firebaseUser != null) {
      return MainScreen.withUser(firebaseUser, auth.currentUser.uid);
    }
    return SignInPage();
  }
}
