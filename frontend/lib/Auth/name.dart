import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/state/authState.dart';
import 'package:parallels/widget/custom/customLoader.dart';
import 'package:provider/provider.dart';
import '../animation/animation.dart';
import '../onboarding/onboarding.dart';
import '../widget/custom/rippleButton.dart';
import 'auth.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback? loginCallback;
  const SignInPage({Key? key, this.loginCallback}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

bool empt = false;

class _SignInPageState extends State<SignInPage> {
  late CustomLoader loader;
  final _nameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _nameController.text.isNotEmpty ? empt = true : empt = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
                onTap: () {
                  var state = Provider.of<AuthState>(context, listen: false);
                  state.logoutCallback();
                  Navigator.push(
                    context,
                    AwesomePageRoute(
                      transitionDuration: Duration(milliseconds: 600),
                      exitPage: widget,
                      enterPage: WelcomePage(),
                      transition: TabletTransition(),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back_ios))),
        backgroundColor: Colors.black,
        body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  var state = Provider.of<AuthState>(context, listen: false);
                  state.logoutCallback();
                  Navigator.push(
                    context,
                    AwesomePageRoute(
                      transitionDuration: Duration(milliseconds: 600),
                      exitPage: widget,
                      enterPage: WelcomePage(),
                      transition: TabletTransition(),
                    ),
                  );
                });
              }
            },
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                ),
                FadeInUp(
                    duration: Duration(seconds: 1),
                    child: FadeInRight(
                        duration: Duration(seconds: 1),
                        child: Lottie.network(
                          "https://assets9.lottiefiles.com/packages/lf20_XpVCMJTSQt.json",
                          height: MediaQuery.of(context).size.height / 3,
                        ))),
                Container(
                  height: 50,
                ),
                FadeInRight(
                    duration: Duration(seconds: 1),
                    child: Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: TextField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              setState(() {
                                _nameController.text.isNotEmpty
                                    ? empt = true
                                    : empt = false;
                              });
                            },
                            keyboardAppearance: Brightness.dark,
                            controller: _nameController,
                            decoration: InputDecoration(
                                hintText: 'Nom',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 70,
                                    fontWeight: FontWeight.w800)),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 70,
                                fontWeight: FontWeight.w800)))),
                Container(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RippleButton(
                      splashColor: Colors.transparent,
                      child: Container(
                          height: 70,
                          width: 200,
                          decoration: BoxDecoration(
                            color: empt ? Colors.white : Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: Text(
                            "Next",
                            style: TextStyle(
                                fontFamily: "icons.ttf",
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ))),
                      onPressed: () {
                        if (_nameController.text.isNotEmpty &&
                            _nameController.text.length < 30) {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                            context,
                            AwesomePageRoute(
                              transitionDuration: Duration(milliseconds: 600),
                              exitPage: widget,
                              enterPage: AuthPage(name: _nameController.text),
                              transition: ZoomOutSlideTransition(),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ))));
  }
}
