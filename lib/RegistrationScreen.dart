import 'package:firebase_auth/firebase_auth.dart';
import 'package:forest_island/AuthScreen.dart';

import './authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Registration',
              style: new TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
                // color: Color.fromRGBO(71, 82, 94, 1)
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  context.read<AuthenticationService>().signUp
                  (
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  Navigator.pushNamed(context, "/auth");
                },
                child: Text("Sign Up"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: GestureDetector(
                onTap: () => {Navigator.pushNamed(context, "/signin")},
                child: Text(
                  'Do you already have an account?',
                  style: new TextStyle
                  (
                    fontSize: 11, color: Color.fromRGBO(129, 144, 165, 1)
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
