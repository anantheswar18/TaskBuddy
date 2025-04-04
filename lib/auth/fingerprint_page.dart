import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:think_todo_list/auth/local_auth.dart';
import 'package:think_todo_list/bottomBar/bottom_nav_bar.dart';
import 'package:think_todo_list/constants/const.dart';
import 'package:think_todo_list/utils/animated_task_buddy_text.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _isAuthenticating = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    // Attempt authentication
    final isAuthenticated = await LocalAuthApi.authenticate();

    setState(() {
      _isAuthenticating = false;
      _isAuthenticated = isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticating) {
      // Show loading screen while authenticating
      return Scaffold(
        backgroundColor: tileColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Please authenticate to access TaskBuddy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    } else if (_isAuthenticated) {
      // Show splash screen after successful authentication
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
    } else {
      // Authentication failed
      return Scaffold(
        backgroundColor: tileColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Authentication failed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isAuthenticating = true;
                  });
                  _authenticate();
                },
                child: Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
