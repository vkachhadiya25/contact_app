import 'package:calculater_app/utils/shr_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  bool? status;

  @override
  void initState() {
    super.initState();
    createData();
  }

  void createData() async{
    ShareHelper shr = ShareHelper();
    status =  await shr.getIntroStatus();
  }

  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(
          context, status == false || status == null ? 'intro' : 'contact');

    });
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/call.png",
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
