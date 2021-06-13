import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forest_island/screens/AuthScreen.dart';
import 'package:forest_island/widgets/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green[600],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Регистрация',
              style: new TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
                color: Colors.white
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                controller: emailController,
                style: new TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white, 
                      width: 1.0
                    ),
                  ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, 
                      width: 1.0
                      ),
                    ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                obscureText: true,
                style: new TextStyle(color: Colors.white),
                controller: passwordController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white, 
                      width: 1.0
                    ),
                  ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white, 
                      width: 1.0
                      ),
                    ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
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
                child: AutoSizeText("Подтвердить", maxLines: 1, style: new TextStyle(color: Colors.green[600], fontSize: 16)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: GestureDetector(
                onTap: () => {Navigator.pushNamed(context, "/signin")},
                child: Text(
                  'У Вас уже есть аккаунт?',
                  style: new TextStyle
                  (
                    fontSize: 14, 
                    color: Colors.white
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
