import 'package:flutter/material.dart';

class OfficeHomePage extends StatefulWidget {
  const OfficeHomePage({super.key});

  @override
  State<OfficeHomePage> createState() => _OfficeHomePageState();
}

class _OfficeHomePageState extends State<OfficeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Office Page"),
      ),
    );
  }
}
