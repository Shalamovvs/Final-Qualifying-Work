import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:page_transition/page_transition.dart';

class RegistrationFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = new MaskedTextController(mask: '7(000)000-00-00');
    dynamic fieldText = '';
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 320, maxHeight: 568),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text(
                          'Регистрация',
                          style: new TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text(
                            'Введите номер телефона, чтобы получить код авторизации',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.grey[800])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Container(
                        child: TextField(
                          controller: controller,
                          onChanged: (text) {
                            fieldText = text;
                          },
                          style: TextStyle(color: Colors.grey[700]),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: '+7(',
                            hintStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: FlatButton(
                        onPressed: () {
                          fieldText = int.parse(fieldText.replaceAll(
                              new RegExp(r'[^\w\s]+'), ''));
                          print(fieldText);
                          Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RegistrationSecondPage()));
                        },
                        color: Colors.blue[900],
                        disabledColor: Colors.blue[900],
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        child: Text('Отправить код',
                            style: new TextStyle(fontSize: 16)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic fieldText = '';
    bool isCodeEntered = false;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 320, maxHeight: 568),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text(
                          'Регистрация',
                          style: new TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text('Введите код из СМС',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.grey[800])),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Container(
                              width: 40,
                              child: TextField(
                                autofocus: true,
                                maxLength: 1,
                                showCursor: false,
                                onChanged: (text) {
                                  fieldText = '$fieldText$text';
                                  node.nextFocus();
                                },
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 30),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Container(
                              width: 40,
                              child: TextField(
                                onChanged: (text) {
                                  fieldText = '$fieldText$text';
                                  node.nextFocus();
                                },
                                maxLength: 1,
                                showCursor: false,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 30),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Container(
                              width: 40,
                              child: TextField(
                                onChanged: (text) {
                                  fieldText = '$fieldText$text';
                                  node.nextFocus();
                                },
                                maxLength: 1,
                                showCursor: false,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 30),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Container(
                              width: 40,
                              child: TextField(
                                onChanged: (text) {
                                  fieldText = '$fieldText$text';
                                  isCodeEntered = true;
                                },
                                maxLength: 1,
                                showCursor: false,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 30),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[700],
                                        style: BorderStyle.solid,
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (!isCodeEntered)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              child: Text(
                                  'Отправить код повторно можно через 59 секунд',
                                  textAlign: TextAlign.center,
                                  style:
                                      new TextStyle(color: Colors.grey[800])),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 8),
                            child: FlatButton(
                              onPressed: () {
                                fieldText = int.parse(fieldText);
                                Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RegistrationThirdPage()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  side: BorderSide(color: Colors.blue[900])),
                              color: Colors.white,
                              disabledColor: Colors.white,
                              textColor: Colors.blue[900],
                              disabledTextColor: Colors.blue[900],
                              child: Text('Отправить повторно',
                                  style: new TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: FlatButton(
                          onPressed: () {
                            fieldText = int.parse(fieldText);
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: RegistrationSecondPage()));
                          },
                          color: Colors.blue[900],
                          disabledColor: Colors.blue[900],
                          textColor: Colors.white,
                          disabledTextColor: Colors.white,
                          child: Text('Подтвердить',
                              style: new TextStyle(fontSize: 16)),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class RegistrationThirdPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 320, maxHeight: 568),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text(
                          'Регистрация',
                          style: new TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: Text(
                            'У тебя есть промокод?\n Введи его и получи бонусы',
                            textAlign: TextAlign.center,
                            style: new TextStyle(color: Colors.grey[800])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Container(
                        child: TextField(
                          onChanged: (text) {
                          },
                          style: TextStyle(color: Colors.grey[700]),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                style: BorderStyle.solid,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.grey[700],
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: 'Промокод',
                            hintStyle:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: FlatButton(
                        onPressed: () {
                          
                        },
                        color: Colors.blue[900],
                        disabledColor: Colors.blue[900],
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        child: Text('Подтвердить',
                            style: new TextStyle(fontSize: 16)),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        
                      },
                      color: Colors.blue[900],
                      disabledColor: Colors.blue[900],
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      child: Text('Пропустить',
                          style: new TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
