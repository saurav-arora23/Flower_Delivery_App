import 'dart:async';

import 'package:flower_delivery_app/appStyle/app_colors.dart';
import 'package:flower_delivery_app/appStyle/app_fonts.dart';
import 'package:flower_delivery_app/appStyle/app_images.dart';
import 'package:flower_delivery_app/appStyle/app_strings.dart';
import 'package:flower_delivery_app/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen())),
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Image.asset(
            AppImages.splashScreen,
            width: MediaQuery.of(context).size.width * double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(AppImages.logo)),
              Text(
                AppStrings.splashScreen,
                style: TextStyle(
                  color: AppColors.pinkColor,
                  fontSize: MediaQuery.of(context).size.height * 0.032,
                  fontFamily: AppFonts.montserratBold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
