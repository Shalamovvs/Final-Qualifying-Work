import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

void deleteFavoriteDialog(BuildContext context) async {
 AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    content: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 145,
        child: Column(
          children: [
            Container(
              child: AutoSizeText("Внимание!", maxLines: 1, textAlign: TextAlign.center, style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w600))
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 25, left: 8, right: 8),
              child: Container(
                child: AutoSizeText("Вы хотите удалить товар \n из избранного", maxLines: 2, textAlign: TextAlign.center, style: new TextStyle(color: Colors.black))
              ),
            ),
            Container(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                          ),
                          right: BorderSide(
                            width: 0.5,
                            color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                          ),
                        )
                      ),
                      child: FlatButton(
                        child: AutoSizeText("Продолжить", maxLines: 1, style: new TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                          ),
                          left: BorderSide(
                            width: 0.5,
                            color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff')))
                          ),
                        )
                      ),
                      child: FlatButton(
                        child: AutoSizeText("Нет", maxLines: 1, style: new TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(int.parse('#E25C2A'.replaceAll('#', '0xff'))))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}