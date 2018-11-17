import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DoubleBackExitApp extends StatefulWidget {
  const DoubleBackExitApp({
    Key key,
    this.onShowExitHint,
    this.duration = const Duration(seconds: 2),
    @required this.child,
  }) : super(key: key);

  /// child
  final Widget child;

  /// 两次回退间隔
  final Duration duration;

  /// 显示退出提示
  final VoidCallback onShowExitHint;

  @override
  _DoubleBackExitAppState createState() => _DoubleBackExitAppState();
}

class _DoubleBackExitAppState extends State<DoubleBackExitApp> {
  final _closeAppSubject = PublishSubject();

  @override
  void initState() {
    super.initState();

    _closeAppSubject.timeInterval().listen((interval) {
      if (interval.interval < widget.duration) {
        exit(0);
      } else {
        if (widget.onShowExitHint != null) {
          widget.onShowExitHint();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _closeAppSubject.close();
    super.dispose();
  }
}