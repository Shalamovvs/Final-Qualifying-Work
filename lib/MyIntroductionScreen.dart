import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

List<PageViewModel> getPages(_screenWidth, _screenHeight) {
  return [
    PageViewModel(
      title: "",
      bodyWidget: Container(
        width: _screenWidth,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/introduction2.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Витаминка - \n доставка свежих продуктов',
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 18, color: Colors.grey[850]),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "",
      bodyWidget: Center(
        child: Container(
          width: _screenWidth,
          height: _screenHeight/2,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 80, right: 8, left: 8, bottom: 50),
                child: Container(
                  child: Text(
                    'Выберите способ доставки:',
                    style: new TextStyle(fontSize: 18, color: Colors.grey[850]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: ()
                  {

                  },
                  color: Colors.blue,
                  disabledColor: Colors.blue[900],
                  textColor: Colors.white,
                  disabledTextColor: Colors.white,
                  child: Text('Заберу сам', style: new TextStyle(fontSize: 16)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: ()
                  {
                    
                  },
                  color: Colors.blue,
                  disabledColor: Colors.blue[900],
                  textColor: Colors.white,
                  disabledTextColor: Colors.white,
                  child: Text('Доставка', style: new TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    PageViewModel(
      title: "",
      bodyWidget: Center(
        child: Container(
          width: _screenWidth,
          height: _screenHeight/2,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: _screenHeight, maxWidth: _screenWidth, minWidth: 320, minHeight: 568),
              child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 80, right: 18, left: 18, bottom: 50),
                  child: Text(
                    'Зарегистрируйся, и получи 30 бонусов и потрать их на покупки',
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 18, color: Colors.grey[850]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FlatButton(
                    onPressed: ()
                  {
                    
                  },
                    color: Colors.blue[900],
                    disabledColor: Colors.blue[900],
                    textColor: Colors.white,
                    disabledTextColor: Colors.white,
                    child: Text('Зарегистрироваться',
                        style: new TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  ];
}

class MyIntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    print('${MediaQuery.of(context).size.height}');
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: getPages(screenWidth, screenHeight),
          showNextButton: true,
          showSkipButton: true,
          skip:
              Text("Пропустить", style: new TextStyle(color: Colors.blue[900])),
          done:
              Text("Продолжить", style: new TextStyle(color: Colors.blue[900])),
          onDone: () => Navigator.pushNamed(context, "/auth")),
    );
  }
}
