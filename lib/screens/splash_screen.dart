import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/utils/base_colors.dart';
import 'package:food_app/utils/base_images.dart';
import 'package:food_app/utils/preference_manager.dart';
import 'package:food_app/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    navigate();
  }

  navigate() async {
    final nav = Navigator.of(context);
    final PreferenceManager preferenceManager = PreferenceManager();

    var isLogin = await preferenceManager.readUser ?? false;

    Timer(const Duration(milliseconds: 2500), () {
      nav.pushNamedAndRemoveUntil(
        isLogin ? Routes.home : Routes.login,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.pink,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Image(
            image: AssetImage(BaseImages.logo),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
