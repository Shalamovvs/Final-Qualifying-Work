import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forest_island/AuthScreen.dart';
import 'package:forest_island/CartScreen.dart';
import 'package:forest_island/HomeScreen.dart';
import 'package:forest_island/ContactsScreen.dart';
import 'package:forest_island/ListScreen.dart';
import 'package:forest_island/MapWidgetRav.dart';
import 'package:forest_island/NewsScreen.dart';
import 'package:forest_island/PersonalScreen.dart';
import 'package:forest_island/RegistrationScreen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forest_island/SearchScreen.dart';
import 'package:forest_island/SignInPage.dart';
import 'package:forest_island/TestScreen.dart';
import 'package:forest_island/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.black
    // ));
    SystemChrome.setEnabledSystemUIOverlays([]);
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
        home: TestScreen(),
        routes: {
          '/auth': (BuildContext context) => AuthScreen(),
          '/card': (BuildContext context) => ListScreen(),
          '/home': (BuildContext context) => PersonalScreen(),
          '/registration': (BuildContext context) => RegistrationScreen(),
          '/signin': (BuildContext context) => SignInPage(),
          '/authWrapper': (BuildContext context) => AuthenticationWrapper(),
          '/contacts': (BuildContext context) => ContactsScreen()
        },
        initialRoute: '/',
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
      return PersonalScreen.withUser(firebaseUser, auth.currentUser.uid);
    }
    return SignInPage();
  }
}
