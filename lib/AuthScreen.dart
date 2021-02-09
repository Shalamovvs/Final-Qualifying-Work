import 'package:flutter/material.dart';
import 'package:forest_island/RegistrationScreen.dart';
import 'package:forest_island/SignInScreen.dart';
import 'package:forest_island/main.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Raster.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Text(
                    'Поселок \n "Лесной остров"',
                    style: new TextStyle(
                      height: 1,
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: 50,
                  height: 50,
                  child: ButtonSheet(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: Icon(Icons.login),
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) => 
          Container(
            height: 200,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Welcome',
                    style: new TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: Text(
                    'Личный кабинет для жителей поселка \n\n "Лесной Остров"',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 15,
                      height: 0.6,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 100, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    onPressed: () => Navigator.pushNamed(context, "/authWrapper"),
                    child: Text(
                      'Sign in',
                      style: new TextStyle(
                        fontSize: 18, 
                      ),
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "/registration")
                    },
                    child: Text(
                      'Don\'t have an account? Sign up here',
                      style: new TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  )
                )
              ],
            ),
          )
        );
      },
    );
  }
}
