import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  bool isWatch = false;
  String watchColor;

  BehaviorSubject<bool> _subjectWatched;
  BehaviorSubject<String> _subjectWatchColor;

  StoriesBloc({this.isWatch, this.watchColor}) {
    _subjectWatched = new BehaviorSubject<bool>.seeded(this.isWatch);
    _subjectWatchColor = new BehaviorSubject<String>.seeded(this.watchColor);
  }

  Observable<bool> get subjectWatchObservable => _subjectWatched.stream;
  Observable<String> get subjectWatchColorObservable => _subjectWatchColor.stream;

  void changeWatched(isWatch, watchColor) {
    if (isWatch == false) {
      isWatch = !isWatch;
      watchColor = '0xff00000000';
    }
    _subjectWatched.sink.add(isWatch);
    _subjectWatchColor.sink.add(watchColor);
  }

  void dispose() {
    _subjectWatched.close();
    _subjectWatchColor.close();
  }
}
