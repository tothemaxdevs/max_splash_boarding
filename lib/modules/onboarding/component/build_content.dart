import 'package:flutter/material.dart';
import 'package:max_splash_boarding/config/size/size.config.dart';
import 'package:max_splash_boarding/utils/view/view_utils.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    this.title,
    this.color = '#ffffff',
    this.description,
    this.imageAsset,
  });

  final String? title, description, imageAsset, color;

  @override
  Widget build(BuildContext context) {
    initSizeConfig(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                // textAlign: TextAlign.center,
              ),
              sizeH(12),
              Text(
                description ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              sizeH(32),
            ],
          ),
          Image.asset(imageAsset!)
        ],
      ),
    );
  }
}
