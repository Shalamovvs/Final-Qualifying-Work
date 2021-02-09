import './authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
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
          children: [
            Text(
              'Sign in',
              style: new TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white))
                ),
              ),
            ),
            Container(
              width: 270,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white)),
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
                  context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    );
                },
                child: Text("Sign in"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Text(
                'Forgot password?',
                style: new TextStyle(
                  fontSize: 11,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
