import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_splash_boarding/config/size/size.config.dart';
import 'package:max_splash_boarding/modules/onboarding/component/build_content.dart';
import 'package:max_splash_boarding/modules/onboarding/model/onboarding_model.dart';
import 'package:max_splash_boarding/src/components/max_button.dart';
import 'package:max_splash_boarding/utils/view/view_utils.dart';

class MaxBoarding extends StatefulWidget {
  Function()? onRoute;
  String? texButton, textToast;
  List<OnboardingData> boarding;

  MaxBoarding(
      {super.key,
      required this.boarding,
      this.onRoute,
      this.texButton,
      this.textToast});

  @override
  _MaxBoardingState createState() => _MaxBoardingState();
}

class _MaxBoardingState extends State<MaxBoarding> {
  @override
  void initState() {
    super.initState();
  }

  DateTime? currentBackPressTime;
  String? title;
  int currentPage = 0;

  PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isLast = widget.boarding.length - 1 == currentPage;
    log(isLast.toString());

    return Scaffold(
      appBar: appBar(context, title: '', actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: MaxButton(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              text: 'Lewati',
              color: Colors.transparent,
              fontWeight: FontWeight.w500,
              press: widget.onRoute),
        )
      ]),
      body: WillPopScope(
        onWillPop: onExit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: controller,
                  itemCount: widget.boarding.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                        title: widget.boarding[index].title,
                        description: widget.boarding[index].description,
                        imageAsset: widget.boarding[index].images,
                      )),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // !isLast?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.boarding.length,
                      (index) => Container(
                        margin: EdgeInsets.only(
                            right: index == widget.boarding.length - 1 ? 0 : 8),
                        child: buildDot(index),
                      ),
                    ),
                  ),
                  sizeH(16),
                  Column(
                    children: [
                      MaxButton(
                        textColor: Colors.black,
                        color: const Color(0xFFFFC700),
                        text: widget.texButton!,
                        width: double.infinity,
                        fontWeight: FontWeight.w600,
                        press: () {
                          !isLast
                              ? controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut)
                              : widget.onRoute;
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 8,
      width: currentPage == index ? 32 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? const Color(0xFFFFC700)
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Future<bool> onExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast(context, widget.textToast!);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
