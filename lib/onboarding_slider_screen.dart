library sk_onboarding_screen;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_slider/onboarding_slider_model.dart';

class OnboardingSliderScreen extends StatefulWidget {
  final List<OnboardingSliderModel> pages;
  final Color bgColor;
  final Color themeColor;

  //loop
  final bool loopPages;
  final Duration loopDuration;

  //skip button
  final bool showSkip;
  final ValueChanged<String> skipClicked;
  //getstarted button
  final bool showgetStarted;
  final ValueChanged<String> getStartedClicked;

  OnboardingSliderScreen({
    Key key,
    @required this.pages,
    @required this.bgColor,
    @required this.themeColor,
    this.loopDuration = const Duration(seconds: 5),
    this.loopPages = true,
    this.skipClicked,
    this.showSkip = true,
    this.getStartedClicked,
    this.showgetStarted = true,
  }) : super(key: key);

  @override
  OnboardingSliderScreenState createState() => OnboardingSliderScreenState();
}

class OnboardingSliderScreenState extends State<OnboardingSliderScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  Timer _timer;
  int _currentPage = 0;
  bool _autochanging = false;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  List<Widget> buildOnboardingPages() {
    final children = <Widget>[];

    for (int i = 0; i < widget.pages.length; i++) {
      children.add(_showPageData(widget.pages[i]));
    }
    return children;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //start timer
    if (widget.loopPages) {
      _timer = new Timer.periodic(
        widget.loopDuration,
        (Timer timer) {
          changeSlides();
        },
      );
    }
  }

  @override
  void dispose() {
    if (widget.loopPages) {
      _timer.cancel();
    }
    super.dispose();
  }

  void changeSlides() {
    _autochanging = true;
    if (_currentPage == widget.pages.length - 1) {
      _currentPage = 0;
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      _currentPage += 1;
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
    setState(() {});
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 15.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? widget.themeColor : Color(0xFF929794),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  widget.showSkip
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              widget.skipClicked("Skip Tapped");
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    height: 500.0,
                    color: Colors.transparent,
                    child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          //to differentiate manual scroll
                          if (_autochanging == false) {
                            if (widget.loopPages) {
                              _timer.cancel();
                            }
                          }
                          _autochanging = false;
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: buildOnboardingPages()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  // _currentPage != widget.pages.length - 1
                  //     ? Expanded(
                  //         child: Align(
                  //           alignment: FractionalOffset.bottomRight,
                  //           child: Padding(
                  //             padding: EdgeInsets.only(right: 20, bottom: 10),
                  //             child: FloatingActionButton(
                  //               backgroundColor: widget.bgColor,
                  //               child: Icon(
                  //                 Icons.arrow_forward,
                  //                 color: widget.themeColor,
                  //               ),
                  //               onPressed: () {
                  //                 _pageController.nextPage(
                  //                   duration: Duration(milliseconds: 500),
                  //                   curve: Curves.ease,
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Text(''),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: (_currentPage == widget.pages.length - 1) &&
              widget.showgetStarted == true
          ? _showGetStartedButton()
          : Text(''),
    );
  }

  Widget _showPageData(OnboardingSliderModel page) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(page.imagePath),
              height: 300.0,
              width: 300.0,
            ),
          ),
          SizedBox(height: 30.0),
          Text(
            page.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: page.titleColor,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            page.description,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: page.descripColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showGetStartedButton() {
    // if(widget.showgetStarted == false){
    //   return Container();
    // }
    final GestureDetector loginButtonWithGesture = new GestureDetector(
      onTap: _getStartedTapped,
      child: new Container(
        height: 50.0,
        decoration: new BoxDecoration(
            color: widget.themeColor,
            borderRadius: new BorderRadius.all(Radius.circular(6.0))),
        child: new Center(
          child: new Text(
            'Get Started',
            style: new TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );

    return new Padding(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0),
        child: loginButtonWithGesture);
  }

  void _getStartedTapped() {
    widget.getStartedClicked("Get Started Tapped");
  }
}
