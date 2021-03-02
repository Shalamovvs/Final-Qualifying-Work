library flutter_stories;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Callback function that accepts the index of moment and
/// returns its' Duration
///
typedef Duration MomentDurationGetter(int index);

///
/// Builder function that accepts current build context, moment index,
/// moment progress and gap between each segment and returns widget for segment
///
typedef Widget ProgressSegmentBuilder(
    BuildContext context, int index, double progress, double gap);

///
/// Widget that allows you to use stories mechanism in your apps
///
/// **Usage:**
///
/// ```dart
/// StoryWidget(
///   onFlashForward: Navigator.of(context).pop,
///   onFlashBack: Navigator.of(context).pop,
///   momentCount: 4,
///   momentDurationGetter: (idx) => Duration(seconds: 4),
///   momentBuilder: (context, idx) {
///     return Container(
///       color: CupertinoColors.destructiveRed,
///       child: Center(
///         child: Text(
///           'Moment ${idx + 1}',
///           style: TextStyle(color: CupertinoColors.white),
///         ),
///       ),
///     );
///   },
/// )
/// ```
///
class StoryWidget extends StatefulWidget {
  const StoryWidget(
      {Key key,
      this.momentBuilder,
      this.momentDurationGetter,
      this.momentCount,
      this.onFlashForward,
      this.onFlashBack,
      this.progressSegmentBuilder = StoryWidget.instagramProgressSegmentBuilder,
      this.progressSegmentGap = 2.0,
      this.progressOpacityDuration = const Duration(milliseconds: 300),
      this.momentSwitcherFraction = 0.33,
      this.startAt = 0,
      this.topOffset,
      this.fullscreen = true,
      this.storyTitle,
      this.uploadTime,
      this.url})
      : assert(momentCount != null),
        assert(momentCount > 0),
        assert(momentDurationGetter != null),
        assert(momentBuilder != null),
        assert(momentSwitcherFraction != null),
        assert(momentSwitcherFraction >= 0),
        assert(momentSwitcherFraction < double.infinity),
        assert(progressSegmentGap != null),
        assert(progressSegmentGap >= 0),
        assert(progressOpacityDuration != null),
        assert(momentSwitcherFraction < double.infinity),
        assert(startAt != null),
        assert(startAt >= 0),
        assert(startAt < momentCount),
        assert(fullscreen != null),
        super(key: key);

  ///
  /// Builder that gets executed executed for each moment
  ///
  final IndexedWidgetBuilder momentBuilder;

  ///
  /// Function that must return Duration for each moment
  ///
  final MomentDurationGetter momentDurationGetter;

  ///
  /// Sets the number of moments in StoryWidget
  ///
  final int momentCount;

  ///
  /// Gets executed when user taps the right portion of the screen
  /// on the last moment in StoryWidget or when StoryWidget finishes playing
  ///
  final VoidCallback onFlashForward;

  ///
  /// Gets executed when user taps the left portion
  /// of the screen on the first moment in StoryWidget
  ///
  final VoidCallback onFlashBack;

  ///
  /// Sets the ratio of left and right tappable portions
  /// of the screen: left for switching back, right for switching forward
  ///
  final double momentSwitcherFraction;

  ///
  /// Builder for each progress segment
  /// Defaults to Instagram-like minimalistic segment builder
  ///
  final ProgressSegmentBuilder progressSegmentBuilder;

  ///
  /// Sets the gap between each progress segment
  ///
  final double progressSegmentGap;

  ///
  /// Sets the duration for the progress bar show/hide animation
  ///
  final Duration progressOpacityDuration;

  ///
  /// Sets the index of the first moment that will be displayed
  ///
  final int startAt;

  ///
  /// Controls progress segments's container oofset from top of the screen
  ///
  final double topOffset;

  ///
  /// Controls fullscreen behavior
  ///
  final bool fullscreen;

  final String storyTitle;

  final int uploadTime;

  final String url;

  static Widget instagramProgressSegmentBuilder(
     BuildContext context, int index, double progress, double gap) =>
      Container(
        height: 2.0,
        margin: EdgeInsets.symmetric(horizontal: gap / 2),
        decoration: BoxDecoration(
          color: Color(0x80ffffff),
          borderRadius: BorderRadius.circular(1.0),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progress,
          child: Container(
            color: Color(0xffffffff),
          ),
        ),
      );

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _currentIdx;
  bool _isInFullscreenMode = false;

  void _switchToNextOrFinish() {
    _controller.stop();
    if (_currentIdx + 1 >= widget.momentCount &&
        widget.onFlashForward != null) {
      widget.onFlashForward();
    } else if (_currentIdx + 1 < widget.momentCount) {
      _controller.reset();
      setState(() => _currentIdx += 1);
      _controller.duration = widget.momentDurationGetter(_currentIdx);
      _controller.forward();
    } else if (_currentIdx == widget.momentCount - 1) {
      setState(() => _currentIdx = widget.momentCount);
    }
  }

  void _switchToPrevOrFinish() {
    _controller.stop();
    if (_currentIdx - 1 < 0 && widget.onFlashBack != null) {
      widget.onFlashBack();
    } else {
      _controller.reset();
      if (_currentIdx - 1 >= 0) {
        setState(() => _currentIdx -= 1);
      }
      _controller.duration = widget.momentDurationGetter(_currentIdx);
      _controller.forward();
    }
  }

  void _onTapDown(TapDownDetails details) => _controller.stop();

  void _onTapUp(TapUpDetails details) {
    final width = MediaQuery.of(context).size.width;
    if (details.localPosition.dx < width * widget.momentSwitcherFraction) {
      _switchToPrevOrFinish();
    } else {
      _switchToNextOrFinish();
    }
  }

  void _onLongPress() {
    _controller.stop();
    setState(() => _isInFullscreenMode = true);
  }

  void _onLongPressEnd() {
    setState(() => _isInFullscreenMode = false);
    _controller.forward();
  }

  Future<void> _hideStatusBar() => SystemChrome.setEnabledSystemUIOverlays([]);
  Future<void> _showStatusBar() => SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  @override
  void initState() {
    if (widget.fullscreen) {
      _hideStatusBar();
    }

    _currentIdx = widget.startAt;

    _controller = AnimationController(
      vsync: this,
      duration: widget.momentDurationGetter(_currentIdx),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _switchToNextOrFinish();
        }
      });

    _controller.forward();

    super.initState();
  }

  @override
  void didUpdateWidget(StoryWidget oldWidget) {
    if (widget.fullscreen != oldWidget.fullscreen) {
      if (widget.fullscreen) {
        _hideStatusBar();
      } else {
        _showStatusBar();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.fullscreen) {
      _showStatusBar();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        widget.momentBuilder(
          context,
          _currentIdx < widget.momentCount
              ? _currentIdx
              : widget.momentCount - 1,
        ),
        Positioned(
          top: widget.topOffset - 20 ?? MediaQuery.of(context).padding.top,
          left: 15,
          right: 8.0 - widget.progressSegmentGap / 2,
          child: AutoSizeText('${widget.storyTitle} ${widget.uploadTime}h',maxLines: 1,style: new TextStyle(fontSize: 14,fontWeight: FontWeight.normal ,color: Colors.white,decoration: TextDecoration.none))
        ),
        Positioned(
          top: widget.topOffset - 23 ?? MediaQuery.of(context).padding.top,
          // left: 8.0 - widget.progressSegmentGap / 2,
          right: 15,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: Colors.white)
          )
        ),
        Positioned(
          top: widget.topOffset ?? MediaQuery.of(context).padding.top,
          left: 3.0 - widget.progressSegmentGap / 2,
          right: 8.0 - widget.progressSegmentGap / 2,
          child: AnimatedOpacity(
            opacity: _isInFullscreenMode ? 0.0 : 1.0,
            duration: widget.progressOpacityDuration,
            child: Row(
              children: <Widget>[
                ...List.generate(
                  widget.momentCount,
                  (idx) {
                    return Expanded(
                      child: idx == _currentIdx
                          ? AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                return widget.progressSegmentBuilder(
                                  context,
                                  idx,
                                  _controller.value,
                                  widget.progressSegmentGap,
                                );
                              },
                            )
                          : widget.progressSegmentBuilder(
                              context,
                              idx,
                              idx < _currentIdx ? 1.0 : 0.0,
                              widget.progressSegmentGap,
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: AutoSizeText('Перейти >', maxLines: 1, style: new TextStyle(fontSize: 14, color: Colors.white)),
                onPressed: () {
                  launch("${widget.url}");
                },
              )
            ),
          )
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          bottom: 50,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onLongPress: _onLongPress,
            onLongPressUp: _onLongPressEnd,
          ),
        ),
      ],
    );
  }
}
