import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:forest_island/StoriesBloc.dart';
import 'package:forest_island/widgets/StoryWidget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Stories {
  String storiesTitle;
  String storiesColor;
  Image storiesImage;
  String titleColor;
  bool isWatched;
  String watchColor;
  int uploadTime;
  String storyURL;
  List<Image> storyImages;
  List<String> storyText;

  Stories(
    {
      this.storiesTitle,
      this.storiesColor,
      this.storiesImage,
      this.titleColor,
      this.isWatched,
      this.watchColor,
      this.uploadTime,
      this.storyURL,
      this.storyImages,
      this.storyText
    }
  );
}

class CatalogWidget extends StatelessWidget {

  final _momentDuration = const Duration(seconds: 5);
  List<StoriesBloc> storiesBlocList = [];

  @override
  Widget build(BuildContext context) {
    Stories testStory1 = new Stories(
      storiesTitle: 'Лучшее',
      storiesColor: '#FEF6ED',
      storiesImage: Image.asset('assets/images/RavStories2.png'),
      titleColor: '#000000',
      isWatched: false,
      watchColor: '0xffE25C2A',
      uploadTime: 5,
      storyURL: "https://ravisagro.ru/media-center/news/",
      storyImages: [Image.asset('assets/images/test1.png'),Image.asset('assets/images/test2.png'),Image.asset('assets/images/test3.png')],
      storyText: ['Только в эти выходные при покупке филе, докторская колбаса в подарок', 'Компании "Равис" нужны сотрудники на всех этапах цепочки', 'Новый рецепт приготовления курицы уже в нашем приложении']
    );
    Stories testStory2 = new Stories(
      storiesTitle: 'Новинки',
      storiesColor: '#E25C2A',
      storiesImage: Image.asset('assets/images/RavStories1.png'),
      titleColor: '#FFFFFF',
      isWatched: false,
      watchColor: '0xffE25C2A',
      uploadTime: 4,
      storyURL: "https://ravisagro.ru/media-center/news/",
      storyImages: [Image.asset('assets/images/test3.png'), Image.asset('assets/images/test1.png')],
      storyText: ['Новый рецепт приготовления курицы уже в нашем приложении','Компании "Равис" нужны сотрудники на всех этапах цепочки']
    );
    Stories testStory3 = new Stories(
      storiesTitle: 'Скидки',
      storiesColor: '#AB68C1',
      storiesImage: Image.asset('assets/images/RavStories3.png'),
      titleColor: '#FFFFFF',
      isWatched: false,
      watchColor: '0xffE25C2A',
      uploadTime: 2,
      storyURL: "https://ravisagro.ru/media-center/news/",
      storyImages: [Image.asset('assets/images/test2.png'),Image.asset('assets/images/test3.png')],
      storyText: ['Компании "Равис" нужны сотрудники на всех этапах цепочки','Новый рецепт приготовления курицы уже в нашем приложении']
    );
    Stories testStory4 = new Stories(
      storiesTitle: 'Подарки',
      storiesColor: '#96D5F4',
      storiesImage: Image.asset('assets/images/RavStories1.png'),
      titleColor: '#FFFFFF',
      isWatched: false,
      watchColor: '0xffE25C2A',
      uploadTime: 7,
      storyURL: "https://ravisagro.ru/media-center/news/",
      storyImages: [Image.asset('assets/images/test1.png')],
      storyText: ['']
    );

    List<Stories> storiesList = [
      testStory1,
      testStory2,
      testStory3,
      testStory4,
    ];

    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 1 / 8,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20),
          itemCount: storiesList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            storiesBlocList.add(StoriesBloc(isWatch: false, watchColor: '0xffE25C2A'));
            return Padding(
              padding: const EdgeInsets.only(right: 14, top: 8, bottom: 8),
              child: StreamBuilder(
                  stream: Observable.combineLatest2(
                      storiesBlocList[index].subjectWatchObservable,
                      storiesBlocList[index].subjectWatchColorObservable,
                      (b1, b2) {
                    storiesList[index].isWatched = b1;
                    storiesList[index].watchColor = b2;
                  }),
                  // initialData: false,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return GestureDetector(
                      onTap: () {
                        storiesBlocList[index].changeWatched(storiesList[index].isWatched,storiesList[index].watchColor);
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return Stack(
                              children: <Widget>[
                                CupertinoPageScaffold(
                                  backgroundColor: Colors.transparent,
                                  child: GestureDetector(
                                    child: StoryWidget(
                                      topOffset: 30,
                                      uploadTime: storiesList[index].uploadTime,
                                      url: storiesList[index].storyURL,
                                      storyTitle: storiesList[index].storiesTitle,
                                      onFlashForward: Navigator.of(context).pop,
                                      onFlashBack: Navigator.of(context).pop,
                                      momentCount: storiesList[index].storyImages.length,
                                      fullscreen: true,
                                      momentDurationGetter: (idx) => _momentDuration,
                                      momentBuilder: (context, idx) => Container(
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              child: Image(image: storiesList[index].storyImages[idx].image, fit: BoxFit.cover)
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 100),
                                              child: Container(
                                                alignment: Alignment.bottomCenter,
                                                child: AutoSizeText('${storiesList[index].storyText[idx]}', maxLines: 3,textAlign: TextAlign.center, style: new TextStyle(decoration: TextDecoration.none,fontSize: 18, color: Colors.white))
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onVerticalDragUpdate: (details) {
                                      if (details.delta.dy < 0) {
                                        launch("${storiesList[index].storyURL}");
                                      }
                                    },
                                  )
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(int.parse('${storiesList[index].watchColor}'.replaceAll('#', '0xff'))),
                              spreadRadius: 2,
                              blurRadius: 5
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
          }
          ),
      ),
    );
  }

  @override
  void dispose() {
    int i = 0;
    while (storiesBlocList.length != 0) {
      storiesBlocList[i].dispose();
    }
  }
}
