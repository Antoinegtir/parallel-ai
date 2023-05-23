import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parallels/Auth/login.dart';
import 'package:parallels/Auth/name.dart';
import '../widget/custom/rippleButton.dart';
import '../animation/animation.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void goToHome(context) => Navigator.push(context,
      PageTransition(type: PageTransitionType.fade, child: SignInPage()));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );
  Widget _body() {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          useScrollView: false,
          title: '',
          bodyWidget: Container(
              color: Colors.black,
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Stack(children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: FadeInDown(
                              duration: Duration(milliseconds: 2000),
                              child: FadeInLeft(
                                  duration: Duration(milliseconds: 2000),
                                  child: Lottie.network(
                                    "https://assets9.lottiefiles.com/packages/lf20_1Sx24QOjmg.json",
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                  )))),
                      Container(
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topRight,
                                  colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.7),
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.2),
                                Colors.black.withOpacity(0.1),
                                Colors.black.withOpacity(0.05),
                                Colors.black.withOpacity(0.025),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                              ]))),
                    ])),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Text(
                      'Notes \ntes idées\nrapidepment💡',
                      style: TextStyle(
                          fontFamily: "icons.ttf",
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 9,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ])),
        ),
        PageViewModel(
          useScrollView: false,
          title: '',
          bodyWidget: Container(
              width: MediaQuery.of(context).size.width / 1,
              color: Colors.black,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: FadeInDown(
                          duration: Duration(milliseconds: 2000),
                          child: Lottie.network(
                            "https://assets5.lottiefiles.com/private_files/lf30_cmd8kh2q.json",
                            height: MediaQuery.of(context).size.height / 2.5,
                          ))),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: FadeInDown(
                      duration: Duration(milliseconds: 2000),
                      child: Text(
                          "Elles se reformattent\nparalellement grâce l'IA",
                          style: TextStyle(
                            fontFamily: "icons.ttf",
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width / 8,
                          )),
                    )),
              ])),
        ),
        PageViewModel(
            useScrollView: false,
            title: '',
            bodyWidget: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width / 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FadeInDown(
                        duration: Duration(milliseconds: 2000),
                        child: FadeInRight(
                            duration: Duration(milliseconds: 2000),
                            child: Lottie.network(
                              "https://assets9.lottiefiles.com/packages/lf20_sop8cbmc.json",
                              height: MediaQuery.of(context).size.height / 2.5,
                            ))),
                    Container(
                      height: 50,
                    ),
                    Center(
                        child: FadeInUp(
                            child: Text(
                      "Connection Method:",
                      style: TextStyle(
                          fontFamily: "icons.ttf",
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ))),
                    Container(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RippleButton(
                          child: FadeInUp(
                              child: FadeInRight(
                                  child: Container(
                                      height: 70,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "Create Account",
                                        style: TextStyle(
                                            fontFamily: "icons.ttf",
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ))))),
                          onPressed: () {
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              AwesomePageRoute(
                                transitionDuration: Duration(milliseconds: 600),
                                exitPage: widget,
                                enterPage: SignInPage(),
                                transition: ZoomOutSlideTransition(),
                              ),
                            );
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20, right: 60),
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                Navigator.push(
                                  context,
                                  AwesomePageRoute(
                                    transitionDuration:
                                        Duration(milliseconds: 600),
                                    exitPage: widget,
                                    enterPage: LogPage(),
                                    transition: ZoomOutSlideTransition(),
                                  ),
                                );
                              },
                              child: FadeInUp(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already got an account? ",
                                    style: TextStyle(
                                        fontFamily: "icons.ttf",
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontFamily: "icons.ttf",
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              )),
                            )),
                      ],
                    )
                  ],
                ))),
      ],
      done: Text('', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text('Skip'),
      next: Icon(Icons.arrow_forward),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Colors.black,
      nextFlex: 1,
      // isProgressTap: false,
      // isProgress: false,
      // showNextButton: false,
      // freeze: true,
      animationDuration: 1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: _body());
  }
}
