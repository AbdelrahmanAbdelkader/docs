import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/bottomnav.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/splashscreen/splashscreen.dart';
import 'package:sample/screens/ScreensSlector/stream_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateManagment>(
          create: (context) => StateManagment(),
        ),
        ChangeNotifierProvider<BottomNav>(
          create: (context) => BottomNav(),
        ),
        ChangeNotifierProvider<Docs>(
          create: (context) => Docs(),
        ),
        ChangeNotifierProvider<PatientsProv>(
            create: (context) => PatientsProv()),
        ChangeNotifierProvider<Vols>(
          create: (context) => Vols(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('ar', '')],
        title: 'Flutter Demo',
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[50]),
            ),
          ),
          textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              subtitle1: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        home: Splash(),
      ),
    );
  }
}
