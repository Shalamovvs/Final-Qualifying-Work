import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:forest_island/StoriesBloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class StoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Home2(),
    );
  }
}

class Home2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Home2State();
}

class Home2State extends State<Home2> with SingleTickerProviderStateMixin {
  AnimationController controller;
  StoriesBloc _storiesBloc = new StoriesBloc(
    isWatched: false,
  );

  Animation base;
  Animation inverted;
  Animation gap;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    inverted = Tween<double>(begin: 0.0, end: -1.0).animate(base);

    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
  }

  final _momentCount = 5;
  final _momentDuration = const Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    final images = List.generate(
      _momentCount,
      (idx) => Image.asset('assets/images/introduction${idx + 1}.png'),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => {
            controller.forward(),
            Timer(Duration(seconds: 3), () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: GestureDetector(
                    child: Story(
                      onFlashForward: Navigator.of(context).pop,
                      onFlashBack: Navigator.of(context).pop,
                      momentCount: 5,
                      momentDurationGetter: (idx) => _momentDuration,
                      momentBuilder: (context, idx) => images[idx],
                    ),
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy < 0) {
                        //launch("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                        print('Test');
                      }
                    },
                  ));
                },
              );
              _storiesBloc.changeWatched();
            })
          },
          child: StreamBuilder(
              stream: _storiesBloc.subjectWatchObservable,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return RotationTransition(
                  turns: base,
                  child: DashedCircle(
                    gapSize: gap.value,
                    dashes: 20,
                    child: RotationTransition(
                      turns: inverted,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                              'https://i.ytimg.com/vi/jgSZrAXjnI4/maxresdefault.jpg'),
                        ),
                      ),
                    ),
                    color: snapshot.data
                        ? Colors.grey[500]
                        : Colors.deepOrangeAccent,
                  ),
                );
              }),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _storiesBloc.dispose();
  }
}
