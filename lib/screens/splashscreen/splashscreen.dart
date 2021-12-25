import 'package:flutter/material.dart';
import 'package:sample/screens/ScreensSlector/stream_builder.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainStream(),
      imageSrc: 'assets/logo.jpg',
      duration: 3,
      imageSize: 300,
    );
  }
}
