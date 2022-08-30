import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/auth.dart';
import 'package:sample/provider/bottom_navigationController.dart';
import 'package:sample/provider/docs/docs.dart';
import 'package:sample/provider/docs/itemsSearchedInDocs.dart';
import 'package:sample/provider/normalPost.dart';
import 'package:sample/provider/patients/patients.dart';
import 'package:sample/model/role_provider.dart';
import 'package:sample/provider/docs/searchDocController.dart';
import 'package:sample/provider/patients/searchPatientsControler.dart';
import 'package:sample/provider/volanteers.dart';
import 'package:sample/screens/postscreen/posts/normal_post.dart';
import 'package:sample/screens/splashscreen/splashscreen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orie, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Auth()),
            ChangeNotifierProvider(
                create: (context) => BottomNavigationController()),
            ChangeNotifierProvider(create: (context) => NormalPostProvider()),
            ChangeNotifierProvider(create: (context) => PatientsProv()),
            ChangeNotifierProvider(create: (context) => Volanteers()),
            ChangeNotifierProvider(create: (context) => Docs()),
            ChangeNotifierProvider(create: (context) => SearchDocController()),
            ChangeNotifierProvider(create: (context) => ItemsSearchedInDocs()),
            ChangeNotifierProvider(
                create: (context) => SearchPatientsController()),
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
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green[50],
                  ),
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
                ),
              ),
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
      },
    );
  }
}
