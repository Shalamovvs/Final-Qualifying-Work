import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RavRegistationScreen extends StatelessWidget {
  const RavRegistationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = new MaskedTextController(mask: '+ 7 000 000-00-00');
    dynamic fieldText = '';
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Введите ваш номер \n телефона для входа', maxLines: 2,textAlign: TextAlign.center ,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      fieldText = text;
                    },
                    onEditingComplete: () {
                      Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RavSMSRegistrationScreen(fieldText)));
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      hintText: '+7',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white,)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RavSMSRegistrationScreen extends StatelessWidget {
  var phonenumber;
  var controller = new MaskedTextController(mask: '0000');
  dynamic smsCode = '';

  RavSMSRegistrationScreen(phonenumber) {
    this.phonenumber = phonenumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Введите код из СМС', maxLines: 1,textAlign: TextAlign.center ,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18))
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Мы отправили код подтверждения на \n $phonenumber', textAlign: TextAlign.center ,maxLines: 2, style: new TextStyle(fontSize: 14, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  // color: Colors.blue,
                  child: PinFieldAutoFill (
                    decoration: new BoxLooseDecoration(
                      strokeColorBuilder: PinListenColorBuilder(Colors.white, Colors.white),
                      gapSpace: 20,
                      textStyle: new TextStyle(color: Colors.white, fontSize: 18)
                    ),
                    autofocus: true,
                    onCodeSubmitted: (value) {
                      Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RavUserRegScreen()));
                    },
                    onCodeChanged: (value) {
                      smsCode = value;
                    },
                    codeLength: 4
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('получить новый код', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 14)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RavUserRegScreen extends StatelessWidget {
  var controller = TextEditingController();
  var userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Введите ваше \n ФИО', textAlign: TextAlign.center, maxLines: 2, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      userName = text;
                    },
                    onEditingComplete: () {
                      Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RavUserBDReg()));
                    },
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RavUserBDReg extends StatelessWidget {
  var birthDay;
  var controller = new MaskedTextController(mask: '00.00.0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Введите вашу \n дату рождения', textAlign: TextAlign.center, maxLines: 2, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      birthDay = text;
                    },
                    onEditingComplete: () {
                      Navigator.push( context, PageTransition( type: PageTransitionType.fade, child: RavUserCity()));
                    },
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RavUserCity extends StatelessWidget {
  const RavUserCity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: AutoSizeText('Выберите ваш \n населенный пункт', textAlign: TextAlign.center, maxLines: 2, style: new TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: SearchableDropdown.single(
                    iconEnabledColor: Colors.white,
                    underline: Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        border:Border(bottom: BorderSide(color: Colors.white, width: 1))
                      ),
                    ),
                    items: [
                      DropdownMenuItem(child: AutoSizeText('Челябинск', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Chelyabinsk'),
                      DropdownMenuItem(child: AutoSizeText('Екатерингбург', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Ekaterinburg'),
                      DropdownMenuItem(child: AutoSizeText('Чебаркуль', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Chebarkul'),
                      DropdownMenuItem(child: AutoSizeText('Курган', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Kurgan'),
                      DropdownMenuItem(child: AutoSizeText('Челябинск', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Chelyabinsk'),
                      DropdownMenuItem(child: AutoSizeText('Екатерингбург', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Ekaterinburg'),
                      DropdownMenuItem(child: AutoSizeText('Чебаркуль', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )), value: 'Chebarkul'),
                    ],

                    menuBackgroundColor: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))),
                    closeButton: AutoSizeText('Закрыть', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )),
                    searchHint: AutoSizeText('Выберите город', maxLines: 1, style: new TextStyle(color: Colors.white, fontSize: 16 )),
                    onChanged: (value) {
                    },
                    dialogBox: false,
                    isExpanded: true,
                    menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}