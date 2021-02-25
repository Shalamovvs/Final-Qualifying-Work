import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FlatButton(
              child: Text('Оставить отзыв'),
              onPressed: () {
                reviewDialog(context);
              }),
        ),
      ),
    );
  }
}

void reviewDialog(BuildContext context) async {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Оставьте отзыв'),
            Container(
              margin: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Имя",
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              height: 100,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Текст отзыва",
                  filled: true,
                ),
              ),
            ),
            FlatButton(
              child: Text("Отправить отзыв"),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                reviewAnswerDialog(context);
              },
            )
          ],
        ),
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void reviewAnswerDialog(BuildContext context) async {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Спасибо за отзыв'),
            Container(
              margin: EdgeInsets.all(12),
              child: Text('Ваш отзыв появится на сайте и в приложении, после модерации', textAlign: TextAlign.center,)
            ),
            FlatButton(
              child: Text("ОК"),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
