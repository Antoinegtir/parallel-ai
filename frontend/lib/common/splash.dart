import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:parallels/helper/enum.dart';
import 'package:parallels/state/authState.dart';
import 'package:provider/provider.dart';
import '../helper/utility.dart';
import '../onboarding/onboarding.dart';
import '../ui/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  bool isAppUpdated = true;

  void timer() async {
    if (isAppUpdated) {
      cprint("App is updated");
      Future.delayed(const Duration(seconds: 1)).then((_) {
        var state = Provider.of<AuthState>(context, listen: false);
        state.getCurrentUser();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: state.authStatus == AuthStatus.NOT_DETERMINED
          ? Container(
              height: MediaQuery.of(context).size.height / 1,
              width: MediaQuery.of(context).size.width / 1,
              child: Lottie.network(
                  "https://assets4.lottiefiles.com/private_files/lf30_c9ajofwe.json",
                  alignment: Alignment.center))
          : state.authStatus == AuthStatus.NOT_LOGGED_IN
              ? const WelcomePage()
              : HomePage(),
    );
  }
}
