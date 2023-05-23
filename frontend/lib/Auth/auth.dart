// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/Auth/signup.dart';
import 'package:parallels/animation/animation.dart';
import 'package:parallels/state/authState.dart';
import 'package:parallels/widget/custom/rippleButton.dart';
import 'package:provider/provider.dart';
import '../ui/home.dart';

class AuthPage extends StatefulWidget {
  final VoidCallback? loginCallback;
  final String? name;
  const AuthPage({Key? key, this.loginCallback, required this.name})
      : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
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
              height: 50,
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
            //               "Google Sign Up",
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
            //         AuthCredential credential = GoogleAuthProvider.credential(
            //           accessToken: googleAuth.accessToken,
            //           idToken: googleAuth.idToken,
            //         );
            //         UserCredential userCredential =
            //             await _auth.signInWithCredential(credential);
            //         User? user = userCredential.user;
            //         DatabaseReference ref =
            //             FirebaseDatabase.instance.reference();
            //         ref.child('profile').child(user!.uid).set({
            //           'key': user.uid,
            //           'userId': user.uid,
            //           'email': googleUser.email,
            //           'token': googleAuth.idToken,
            //           'displayName': widget.name,
            //           'createdAt': DateTime.now().toUtc().toString(),
            //         });
            //         // Register user in Firebase Realtime Database

            //         // Navigate to profile page
            //         Future.delayed(const Duration(seconds: 0)).then((_) {
            //           var state =
            //               Provider.of<AuthState>(context, listen: false);

            //           state.getCurrentUser();
            //           Navigator.push(
            //             context,
            //             AwesomePageRoute(
            //               transitionDuration: Duration(milliseconds: 600),
            //               exitPage: widget,
            //               enterPage: HomePage(),
            //               transition: CubeTransition(),
            //             ),
            //           );
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
                    enterPage: Signup(
                      name: widget.name,
                    ),
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
                      Icon(
                        FontAwesomeIcons.mailBulk,
                        color: Colors.black,
                        size: 30,
                      ),
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
            // Container(
            //   height: 20,
            // ),
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
            //               "Facebook Sign Up",
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
            //         AuthCredential credential = GoogleAuthProvider.credential(
            //           accessToken: googleAuth.accessToken,
            //           idToken: googleAuth.idToken,
            //         );
            //         UserCredential userCredential =
            //             await _auth.signInWithCredential(credential);
            //         User? user = userCredential.user;

            //         // Register user in Firebase Realtime Database

            //         DatabaseReference ref =
            //             FirebaseDatabase.instance.reference();
            //         ref.child('profile').child(user!.uid).set({
            //           'key': user.uid,
            //           'userId': user.uid,
            //           'email': googleUser.email,
            //           'token': googleAuth.idToken,
            //           'displayName': widget.name,
            //           'userName': widget.name,
            //           'bio': widget.bio.toString() == "" ? "" : widget.bio,
            //           'createdAt': DateTime.now().toUtc().toString(),
            //           // contact:  _mobileController.text,
            //           'dob': DateTime(1950, DateTime.now().month,
            //                   DateTime.now().day + 3)
            //               .toString(),
            //           'location': '',
            //           'profilePic': Constants.dummyProfilePicList[1],
            //           'isVerified': false,
            //           'instagram': '',
            //           'facebook': '',
            //           'twitter': '',
            //           'snapchat': '',
            //           'tiktok': '',
            //           'twitch': '',
            //           'youtube': '',
            //           'github': '',
            //           'promail': '',
            //           'telephone': '',
            //           'pinterest': '',
            //           'web': '',
            //         });
            //         // Register user in Firebase Realtime Database

            //         // Navigate to profile page
            //         Future.delayed(const Duration(seconds: 0)).then((_) {
            //           var state =
            //               Provider.of<AuthState>(context, listen: false);

            //           state.getCurrentUser();
            //           Navigator.push(
            //             context,
            //             AwesomePageRoute(
            //               transitionDuration: Duration(milliseconds: 600),
            //               exitPage: widget,
            //               enterPage: SacePage(file: widget.file),
            //               transition: CubeTransition(),
            //             ),
            //           );
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
        )));
  }
}
