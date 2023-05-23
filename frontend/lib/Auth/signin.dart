import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/widget/custom/customLoader.dart';
import 'package:provider/provider.dart';

import '../helper/utility.dart';
import '../state/authState.dart';

class SignIn extends StatefulWidget {
  final VoidCallback? loginCallback; //!

  const SignIn({Key? key, this.loginCallback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loader = CustomLoader();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width / 1,
              child: Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_drhp9zqp.json')),
          Stack(
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.width / 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                  padding: EdgeInsets.only(right: 0, left: 0),
                  child: Column(
                    children: [
                      _entryFeild('Enter email', controller: _emailController),
                      _entryFeild('Enter password',
                          controller: _passwordController, isPassword: true),
                      Container(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      _emailLoginButton(context),
                      Container(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      _labelButton('Forget password?', onPressed: () {
                        Navigator.of(context).pushNamed('/ForgetPasswordPage');
                      }),
                    ],
                  ),
                ),
              )
            ],
          )
        ]));
  }

  Widget _entryFeild(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        controller: controller,
        keyboardAppearance: Brightness.dark,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: Colors.white),
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          labelText: hint,
          hintText: hint,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            isPassword ? Iconsax.key5 : Icons.supervised_user_circle,
            color: Colors.white,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 163, 163, 163), width: 1.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    );
  }

  Widget _labelButton(String title, {Function? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _emailLoginButton(BuildContext context) {
    return TextButton(
      child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
              child: Text(
            "Submit",
            style: TextStyle(
                fontFamily: "icons.ttf",
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900),
          ))),
      onPressed: _emailLogin,
    );
  }

  void _emailLogin() {
    var state = Provider.of<AuthState>(context, listen: false);
    if (state.isbusy) {
      return;
    }
    loader.showLoader(context);
    var isValid = Utility.validateCredentials(
        context, _scaffoldKey, _emailController.text, _passwordController.text);
    if (isValid) {
      state
          .signIn(_emailController.text, _passwordController.text, context,
              scaffoldKey: _scaffoldKey)
          .then((status) {
        if (state.user != null) {
          loader.hideLoader();
          Future.delayed(const Duration(seconds: 0)).then((_) {
            var state = Provider.of<AuthState>(context, listen: false);

            state.getCurrentUser();
            Navigator.pushNamed(context, "SplashPage");
          });
          widget.loginCallback!();
        } else {
          cprint('Unable to login', errorIn: '_emailLoginButton');
          loader.hideLoader();
        }
      });
    } else {
      loader.hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.black.withOpacity(0.1),
                height: 50,
                width: 50,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      kIsWeb
                          ? 0
                          : Platform.isIOS
                              ? 8
                              : 0,
                      0,
                      0,
                      0),
                  child: BackButton(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.delta.dx > 0) {
              setState(() {
                Navigator.pop(context);
              });
            }
          },
          child: SingleChildScrollView(child: _body(context))),
    );
  }
}
