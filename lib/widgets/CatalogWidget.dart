import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:forest_island/StoriesBloc.dart';
import 'package:rxdart/rxdart.dart';

class Stories {
  String storiesTitle;
  String storiesColor;
  Image storiesImage;
  String titleColor;
  bool isWatched;
  String watchColor;

  Stories(
      {this.storiesTitle,
      this.storiesColor,
      this.storiesImage,
      this.titleColor,
      this.isWatched,
      this.watchColor});
}

class CatalogWidget extends StatelessWidget {
  StoriesBloc _storiesBloc =
      new StoriesBloc(isWatch: false, watchColor: '0xffE25C2A');

  final _momentCount = 5;
  final _momentDuration = const Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    Stories testStory1 = new Stories(
        storiesTitle: 'Лучшее',
        storiesColor: '#FEF6ED',
        storiesImage: Image.asset('assets/images/RavStories2.png'),
        titleColor: '#000000',
        isWatched: false,
        watchColor: '0xffE25C2A');
    Stories testStory2 = new Stories(
        storiesTitle: 'Новинки',
        storiesColor: '#E25C2A',
        storiesImage: Image.asset('assets/images/RavStories1.png'),
        titleColor: '#FFFFFF',
        isWatched: false,
        watchColor: '0xffE25C2A');
    Stories testStory3 = new Stories(
        storiesTitle: 'Скидки',
        storiesColor: '#AB68C1',
        storiesImage: Image.asset('assets/images/RavStories3.png'),
        titleColor: '#FFFFFF',
        isWatched: false,
        watchColor: '0xffE25C2A');
    Stories testStory4 = new Stories(
        storiesTitle: 'Подарки',
        storiesColor: '#96D5F4',
        storiesImage: Image.asset('assets/images/RavStories1.png'),
        titleColor: '#FFFFFF',
        isWatched: false,
        watchColor: '0xffE25C2A');

    List<Stories> storiesList = [
      testStory1,
      testStory2,
      testStory3,
      testStory4,
    ];

    final images = List.generate(
      _momentCount,
      (idx) => Image.asset('assets/images/introduction${idx + 1}.png'),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 90,
      ),
      child: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height * 1 / 8,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: storiesList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: Observable.combineLatest2(
                      _storiesBloc.subjectWatchObservable,
                      _storiesBloc.subjectWatchColorObservable, (b1, b2) {
                        storiesList[index].isWatched = b1;
                        storiesList[index].watchColor = b2;
                      }
                    ),
                    initialData: false,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return GestureDetector(
                        onTap: () {
                          _storiesBloc.changeWatched(storiesList[index].isWatched,storiesList[index].watchColor);
                          // showCupertinoDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return CupertinoPageScaffold(
                          //         child: GestureDetector(
                          //       child: Story(
                          //         onFlashForward: Navigator.of(context).pop,
                          //         onFlashBack: Navigator.of(context).pop,
                          //         momentCount: 5,
                          //         momentDurationGetter: (idx) => _momentDuration,
                          //         momentBuilder: (context, idx) => images[idx],
                          //       ),
                          //       onVerticalDragUpdate: (details) {
                          //         if (details.delta.dy < 0) {
                          //           //launch("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                          //           print('Test');
                          //         }
                          //       },
                          //     ));
                          //   },
                          // );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(int.parse('${storiesList[index].watchColor}'.replaceAll('#', '0xff'))),spreadRadius: 2,blurRadius: 5
                              ),
                            ],
                            // border: Border.all(width: 1,color: Colors.white),
                            color: Color(int.parse('${storiesList[index].storiesColor}'.replaceAll('#', '0xff'))),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Image(image: storiesList[index].storiesImage.image)
                              ),
                              Container(
                                child: Text('${storiesList[index].storiesTitle}',style: new TextStyle(color: Color(int.parse('${storiesList[index].titleColor}'.replaceAll('#', '0xff')))))
                              )
                            ],
                          ),
                          width: 95,
                          height: 100,
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _storiesBloc.dispose();
  }
}
