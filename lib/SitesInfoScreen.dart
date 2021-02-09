import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:getwidget/getwidget.dart';

List<String> jobs = [];
List<String> jobsInfo = [];
var elements = 0;

class SitesInfoScreen extends StatefulWidget {
  @override
  _SitesInfoScreenState createState() => _SitesInfoScreenState();
}

class _SitesInfoScreenState extends State<SitesInfoScreen> {
  @override
  void initState() {
    super.initState();

    http.get('https://www.xpage.ru/hr/').then((response) {
      print("Response status: ${response.statusCode}");
      dom.Document document = parser.parse(response.body);
      List<dom.Element> jobBlocks = document.querySelectorAll(".job__one");

      jobBlocks.forEach((element) {
        var job = element.querySelector('.job__one-title');
        var jobInfo = element.querySelector('.job__one-text');

        job.text = job.text.trim();
        jobInfo.text = jobInfo.text.trim();
        job.text = job.text.replaceAll("\n", " ");
        jobInfo.text = jobInfo.text.replaceAll("\n", " ");

        RegExp exp = RegExp(r'\s+(?![^\d\s])');

        job.text = job.text.replaceAll(exp, "");
        jobInfo.text = jobInfo.text.replaceAll(exp, "");

        if (elements != jobBlocks.length) {
          jobs.add(job.text);
          jobsInfo.add(jobInfo.text);
          elements++;
        }
      });
      setState(() {});
    }).catchError((error) {
      print("Error: $error");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: jobs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFAccordion(
                    title: jobs[index],
                    content: jobsInfo[index],
                    collapsedTitleBackgroundColor: null,
                    expandedTitleBackgroundColor: null,
                    contentBackgroundColor: Colors.black,
                    textStyle: new TextStyle(color: Colors.white),
                    collapsedIcon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    expandedIcon: Icon(
                      Icons.minimize,
                      color: Colors.blue,
                    )
                  ),
                )
              ],
            ),
          );
        }
      ),
    ));
  }
}
