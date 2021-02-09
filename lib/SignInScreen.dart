import 'package:flutter/material.dart';
import 'package:forest_island/PersonalScreen.dart';

class SignInScreen extends StatelessWidget {
  var telephoneNumber;

  void selectPage(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return PersonalScreen();
        },
      ),
    );
  }

  void login(context) {
    if (telephoneNumber != null) {
      if (telephoneNumber.toString().length == 11)
        selectPage(context);
      else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ошибка'),
                content: const Text('Проверьте правильность введеного номера'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка'),
              content: const Text('Введите номер'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign in',
                style: new TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w100,
                    color: Color.fromRGBO(71, 82, 94, 1)),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 250,
                child: TextField(
                  onChanged: (text) {
                    telephoneNumber = text;
                  },
                  onSubmitted: (text) {
                    telephoneNumber = text;
                    login(context);
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(71, 82, 94, 1), width: 1),
                      ),
                      hintText: 'Telephone'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: FlatButton(
                    padding:
                      EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey[800],
                    color: Colors.grey[800],
                    onPressed: () {
                       login(context);
                    },
                    child: Text(
                      'Sign in',
                      style: new TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    'Forgot password?',
                    style: new TextStyle(
                        fontSize: 11, color: Color.fromRGBO(129, 144, 165, 1)),
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
