import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// Animated text for splash screen
class AnimatedTaskBuddyText extends StatelessWidget {
  const AnimatedTaskBuddyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // The GIF image would be above this text
        SizedBox(height: 20), // Space between image and text
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              '📃 TaskBuddy 📃',
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 166, 155, 155),
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: 'Montserrat',
              ),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
        ),
      ],
    );
  }
}
