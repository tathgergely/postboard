
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:postboard/view/board-fragment.dart';
import 'package:postboard/view/control-page.dart';
import 'package:postboard/view/edit-fragment.dart';
import 'package:postboard/view/error-page.dart';
import 'package:postboard/view/home-page.dart';
import 'package:postboard/view/loading-page.dart';
import 'package:postboard/view/login-page.dart';
import 'package:postboard/view/register-page.dart';
import 'package:postboard/viewmodel/board-viewmodel.dart';
import 'package:postboard/viewmodel/control-viewmodel.dart';
import 'package:postboard/viewmodel/home-viewmodel.dart';
import 'package:postboard/viewmodel/login-viewmodel.dart';
import 'package:postboard/viewmodel/register-viewmodel.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StartingPoint());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Provider(
          create: (context) => new ControlViewModel(),
          child: new ControlPage(),
        ),
        '/login': (context) => Provider(
          create: (context) => new LoginViewModel(),
          child: new LoginPage(),
        ),
        '/register': (context) => Provider(
          create: (context) => new RegisterViewModel(),
          child: new RegisterPage(),
        ),
        '/home': (context) => Provider(
          create: (context) => new HomeViewModel(),
          child: new HomePage(),
        ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class StartingPoint extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      future: _initialization,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ErrorPage(),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoadingPage(),
        );
      },
    );
  }
}
