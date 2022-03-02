import 'package:flutter/material.dart';
import 'dart:async';



class SecondPage extends StatefulWidget {
  final Widget startWidget;

  const SecondPage({Key? key, required this.startWidget}) : super(key: key);



  @override
  _SecondPageState createState() => _SecondPageState(startWidget);
}

class _SecondPageState extends State<SecondPage> {
  final Widget startWidget;

  _SecondPageState(this.startWidget);
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    Timer(const Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => startWidget,
          ),
              (route) {
            return false;
          },
        );
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                  ? _h / 2
                  : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                      ? 2
                      : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                  ? 80
                  : 20,
              width: _d
                  ? _w
                  : _c
                  ? 80
                  : 20,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                   //shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius:
                  _d ? const BorderRadius.only() : BorderRadius.circular(100)),
              child: Center(
                child: _e
                    ? Image.asset('assets/images/image.png')
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}
