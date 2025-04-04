import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:think_todo_list/bottomBar/bottom_nav_bar.dart';
import 'package:think_todo_list/constants/const.dart';
import 'package:think_todo_list/utils/animated_task_buddy_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                appBarColor, // Black
                tileColor, // Dark blue
              ],
            ),
          ),
        ),
        AnimatedSplashScreen(
          duration: 3000,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/Todo_anime.gif"),
              ),
              AnimatedTaskBuddyText(),
            ],
          ),
          nextScreen: BottomNavBar(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,
          splashIconSize: 700, // Adjust size as needed
        ),
      ],
    );
  }
}
