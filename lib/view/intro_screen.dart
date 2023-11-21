import 'package:calculater_app/utils/shr_helper.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          pages: [
            PageViewModel(
                title: "Title of introduction page",
                bodyWidget: const Row(
                  children: [
                    Text("Click on "),
                  ],
                )),
            PageViewModel(
                title: "Title of introduction page",
                bodyWidget: const Row(
                  children: [
                    Text("Click on "),
                  ],
                )),
          ],
          showDoneButton: true,
          onDone: () {
            ShareHelper shareHelper = ShareHelper();
            shareHelper.setIntroStatus();
            Navigator.pushReplacementNamed(context, 'contact');
          },
          done: const Text("Done"),
          showNextButton: true,
          next: const Text("Next"),
        ),
      ),
    );
  }
}
