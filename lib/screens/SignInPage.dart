import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:forest_island/widgets/authentication_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
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
          children: [
            AutoSizeText(
              'Войти',
              maxLines: 1,
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
                cursorColor: Colors.white,
                style: new TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white))
                ),
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                obscureText: true,
                style: new TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
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
                  context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    );
                },
                child: AutoSizeText("Подтвердить", maxLines: 1, style: new TextStyle(color: Colors.green[600], fontSize: 16)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(
                'Forgot password?',
                style: new TextStyle(
                  fontSize: 14,
                  color: Colors.white
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
