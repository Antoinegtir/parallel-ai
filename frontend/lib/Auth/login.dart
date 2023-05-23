import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/Auth/signin.dart';
import 'package:parallels/animation/animation.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../state/authState.dart';
import '../widget/custom/rippleButton.dart';

class LogPage extends StatefulWidget {
  final VoidCallback? loginCallback;
  final String? name;
  final String? bio;
  const LogPage({Key? key, this.loginCallback, this.bio, this.name})
      : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<LogPage> {
  StreamSubscription? _subs;
  bool? loader;

  @override
  void initState() {
    loader = false;
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                setState(() {
                  Navigator.pop(context);
                });
              }
            },
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                  ),
                  FadeInUp(
                      duration: Duration(seconds: 1),
                      child: FadeInLeft(
                          duration: Duration(seconds: 1),
                          child: Lottie.network(
                            "https://assets9.lottiefiles.com/packages/lf20_XpVCMJTSQt.json",
                            height: 220,
                          ))),
                  Container(
                    height: 20,
                  ),
                  Text(
                    "Log Method:",
                    style: TextStyle(
                        fontFamily: "icons.ttf",
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                  Container(
                    height: 20,
                  ),
                  // Center(
                  //     child: RippleButton(
                  //         onPressed: onClickGitHubLoginButton,
                  //         child: Container(
                  //           height: 70,
                  //           width: 300,
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(50),
                  //           ),
                  //           child: TextButton(
                  //             onPressed: onClickGitHubLoginButton,
                  //             child: Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(vertical: 0),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 children: [
                  //                   Container(
                  //                     width: 20,
                  //                   ),
                  //                   Image.asset(
                  //                     "assets/images/github.png",
                  //                     height: 30,
                  //                   ),
                  //                   Container(
                  //                     width: 20,
                  //                   ),
                  //                   Text(
                  //                     'GitHub Log In',
                  //                     style: TextStyle(
                  //                         color: Colors.black,
                  //                         fontSize: 23,
                  //                         fontWeight: FontWeight.w100),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ))),
                  Container(
                    height: 20,
                  ),
                  // Center(
                  //   child: RippleButton(
                  //     child: Container(
                  //         height: 70,
                  //         width: 300,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(50),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               width: 30,
                  //             ),
                  //             Icon(
                  //               FontAwesomeIcons.google,
                  //               color: Colors.black,
                  //               size: 30,
                  //             ),
                  //             Container(
                  //               width: 20,
                  //             ),
                  //             Text(
                  //               "Google Sign In",
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 23,
                  //                   fontWeight: FontWeight.w100),
                  //             )
                  //           ],
                  //         )),
                  //     onPressed: () async {
                  //       HapticFeedback.heavyImpact();
                  //       setState(() {
                  //         _isLoading = true;
                  //       });
                  //       try {
                  //         // Sign in with Google
                  //         GoogleSignInAccount? googleUser =
                  //             await _googleSignIn.signIn();
                  //         GoogleSignInAuthentication googleAuth =
                  //             await googleUser!.authentication;
                  //         AuthCredential credential =
                  //             GoogleAuthProvider.credential(
                  //           accessToken: googleAuth.accessToken,
                  //           idToken: googleAuth.idToken,
                  //         );
                  //         UserCredential userCredential =
                  //             await _auth.signInWithCredential(credential);

                  //         // Register user in Firebase Realtime Database
                  //         var state =
                  //             Provider.of<AuthState>(context, listen: false);
                  //         Future.delayed(const Duration(seconds: 0)).then((_) {
                  //           state.getCurrentUser();
                  //           Navigator.pushNamed(context, "SplashPage");
                  //         });
                  //       } catch (error) {
                  //         print(error);
                  //       } finally {
                  //         setState(() {
                  //           _isLoading = false;
                  //         });
                  //       }
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: 20,
                  ),
                  RippleButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        AwesomePageRoute(
                          transitionDuration: Duration(milliseconds: 600),
                          exitPage: widget,
                          enterPage: SignIn(),
                          transition: CubeTransition(),
                        ),
                      );
                    },
                    child: Container(
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                            ),
                            // ClipRRect(
                            //     borderRadius: BorderRadius.circular(50),
                            //     child: Image.asset(
                            //       "assets/images/AppIcon.jpg",
                            //       height: 30,
                            //     )),
                            Container(
                              width: 20,
                            ),
                            Text(
                              "Email Method",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 20,
                  ),
                  // Center(
                  //   child: RippleButton(
                  //     child: Container(
                  //         height: 70,
                  //         width: 300,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(50),
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               width: 30,
                  //             ),
                  //             Image.asset(
                  //               "assets/images/facebook.png",
                  //               height: 30,
                  //             ),
                  //             Container(
                  //               width: 20,
                  //             ),
                  //             Text(
                  //               "Facebook Sign In",
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 23,
                  //                   fontWeight: FontWeight.w100),
                  //             )
                  //           ],
                  //         )),
                  //     onPressed: () async {
                  //       HapticFeedback.heavyImpact();
                  //       setState(() {
                  //         _isLoading = true;
                  //       });
                  //       try {
                  //         // Sign in with Google
                  //         GoogleSignInAccount? googleUser =
                  //             await _googleSignIn.signIn();
                  //         GoogleSignInAuthentication googleAuth =
                  //             await googleUser!.authentication;
                  //         AuthCredential credential =
                  //             GoogleAuthProvider.credential(
                  //           accessToken: googleAuth.accessToken,
                  //           idToken: googleAuth.idToken,
                  //         );
                  //         UserCredential userCredential =
                  //             await _auth.signInWithCredential(credential);
                  //         User? user = userCredential.user;

                  //         // Register user in Firebase Realtime Database

                  //         // Navigate to profile page
                  //         Future.delayed(const Duration(seconds: 0))
                  //             .then((_) {
                  //           var state = Provider.of<AuthState>(context,
                  //               listen: false);

                  //           state.getCurrentUser();
                  //           Navigator.pushNamed(context, "SplashPage");
                  //         });
                  //       } catch (error) {
                  //         print(error);
                  //       } finally {
                  //         setState(() {
                  //           _isLoading = false;
                  //         });
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              )
            ])));
  }
}
