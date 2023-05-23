import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/animation/animation.dart';
import 'package:parallels/helper/constant.dart';
import 'package:parallels/helper/utility.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../state/authState.dart';
import '../ui/home.dart';
import '../widget/custom/customLoader.dart';

class Signup extends StatefulWidget {
  final VoidCallback? loginCallback;
  final String? name;
  final String? bio;
  final File? file;

  const Signup({Key? key, this.loginCallback, this.name, this.bio, this.file})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  late CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    loader = CustomLoader();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
        color: Colors.black,
        child: Column(children: [
          Container(
            height: 90,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width / 1,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_XpVCMJTSQt.json')),
          Stack(
            children: [
              Center(
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.width / 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Column(
                    children: [
                      _entryFeild('Enter email',
                          controller: _emailController, isEmail: true),
                      // _entryFeild('Mobile no',controller: _mobileController),
                      _entryFeild('Enter password',
                          controller: _passwordController, isPassword: true),
                      _entryFeild('Confirm password',
                          controller: _confirmController, isPassword: true),
                      Container(
                        height: 20,
                      ),
                      _submitButton(context),
                    ],
                  ),
                ),
              )
            ],
          )
        ]));
  }

  Widget _entryFeild(String hint,
      {required TextEditingController controller,
      bool isPassword = false,
      bool isEmail = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        keyboardAppearance: Brightness.dark,
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
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

  Widget _submitButton(BuildContext context) {
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
      onPressed: _submitForm,
    );
  }

  void _submitForm() {
    if (_emailController.text.length > 30) {
      Utility.customSnackBar(
          _scaffoldKey, 'Username length cannot exceed 50 character', context);
      return;
    }
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Utility.customSnackBar(
          _scaffoldKey, 'Please fill form carefully', context);
      return;
    } else if (_passwordController.text != _confirmController.text) {
      Utility.customSnackBar(
          _scaffoldKey, 'Password and confirm password did not match', context);
      return;
    }

    loader.showLoader(context);
    var state = Provider.of<AuthState>(context, listen: false);
    Random random = Random();
    int randomNumber = random.nextInt(8);

    UserModel user = UserModel(
      email: _emailController.text.toLowerCase(),
      // contact:  _mobileController.text,
      displayName: widget.name,
      profilePic: Constants.dummyProfilePicList[randomNumber],
    );
    state
        .signUp(
      user,
      context,
      password: _passwordController.text,
      scaffoldKey: _scaffoldKey,
    )
        .then((status) {
      print(status);
    }).whenComplete(
      () {
        loader.hideLoader();
        Future.delayed(const Duration(seconds: 0)).then((_) {
          var state = Provider.of<AuthState>(context, listen: false);

          state.getCurrentUser();
          Navigator.push(
            context,
            AwesomePageRoute(
              transitionDuration: Duration(milliseconds: 600),
              exitPage: widget,
              enterPage: HomePage(),
              transition: CubeTransition(),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      ),
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
