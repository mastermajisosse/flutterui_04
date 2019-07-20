import 'package:flutter/material.dart';
import 'package:flutteui_04/data.dart';
import 'package:flutteui_04/page_indicator.dart';
import 'package:gradient_text/gradient_text.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _controller;
  // AnimationController animationController;
  // Animation<double> _scaleAnimation;

  int currentPage = 0;
  bool lasPage = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentPage);
    // animationController =
    // AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    // _scaleAnimation = Tween(begin: 0.6, end: 1.0).animate(animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF485563),
                Color(0xFF29323C),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              stops: [0.0, 1.0])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              itemCount: pageList.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  if (currentPage == pageList.length - 1) {
                    lasPage = true;
                    // animationController.forward();
                  } else {
                    lasPage = false;
                  }
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        var page = pageList[index];
                        var delta;
                        var y = 1.0;

                        if (_controller.position.haveDimensions) {
                          delta = _controller.page - index;
                          y = 1 - delta.abs().clamp(0.0, 1.0);
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              page.imageUrl,
                              width: 250.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12.0),
                              height: 90.0,
                              child: Stack(
                                children: <Widget>[
                                  Opacity(
                                    opacity: .10,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 22.0),
                                      child: GradientText(
                                        page.title,
                                        gradient: LinearGradient(
                                            colors: page.titleGradient),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 80.0,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 22.0),
                                    child: GradientText(
                                      page.title,
                                      gradient: LinearGradient(
                                          colors: page.titleGradient),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 60.0,
                                          letterSpacing: 1.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.0, left: 34.0),
                              child: Transform(
                                transform: Matrix4.translationValues(
                                    0.0, 50 * (1 - y), 0.0),
                                child: Text(
                                  page.body,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF989898)),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                );
              },
            ),
            Positioned(
              left: 30.0,
              bottom: 55.0,
              child: Container(
                width: 160.0,
                child: PageIndicator(currentPage, pageList.length),
              ),
            ),
            Positioned(
              right: 20.0,
              bottom: 30.0,
              // child: ScaleTransition(
              // scale: _scaleAnimation,
              child: lasPage
                  ? FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    )
                  : Container(),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
