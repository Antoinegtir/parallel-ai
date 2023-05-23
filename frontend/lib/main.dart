import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parallels/common/locator.dart';
import 'package:parallels/common/splash.dart';
import 'package:parallels/model/resolution.dart';
import 'package:parallels/state/appState.dart';
import 'package:parallels/state/authState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupDependencies();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStates>(create: (_) => AppStates()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider(
            create: (context) =>
                MyThemeModel(sharedPreferences: sharedPreferences)),
      ],
      child: MaterialApp(
          title: 'Parallelsai',
          debugShowCheckedModeBanner: false,
          home: SplashPage(key: key)),
    );
  }
}
