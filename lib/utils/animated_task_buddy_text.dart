import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTaskBuddyText extends StatelessWidget {
  const AnimatedTaskBuddyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '📃TaskBuddy📃',
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 90, 90, 132),
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: 'Montserrat',
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
        ),
      ],
    );
  }
}
