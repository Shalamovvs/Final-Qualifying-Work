import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  bool isWatched = false;


  BehaviorSubject<bool> _subjectWatched;

  StoriesBloc({this.isWatched}) {
    _subjectWatched = new BehaviorSubject<bool>.seeded(this.isWatched);
  }

  Observable<bool> get subjectWatchObservable => _subjectWatched.stream;

  void changeWatched() {
    if (isWatched == false) {
      isWatched = !isWatched;
    }
    _subjectWatched.sink.add(isWatched);
  }

  void dispose() {
    _subjectWatched.close();
  }
}
