import 'dart:async';

import 'package:b201_flutter_workshop/challenges/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/main'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blueColor,
        body: Center(
          child: Text(
            "Todo App",
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: semiBold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
