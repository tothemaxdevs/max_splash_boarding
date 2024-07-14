import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

typedef ChildBuilder = Widget Function(
    BuildContext context, ScrollController scrollController);

bottomSheet(
  BuildContext context,
  ChildBuilder childBuilder, {
  String? title,
  String? subtitle,
  Function()? onTapOk,
  Function()? onTapCancel,
  String? textOkButton,
  bool isPrimary = false,
  String? textCancelButton,
  bool? backButton = false,
  bool? hideButton = false,
  double? minChildSize,
  double? maxChildSize,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
            initialChildSize: minChildSize ?? 0.7, // Half screen on load
            maxChildSize: maxChildSize ?? 0.95, // Full screen on scroll
            minChildSize: minChildSize ?? 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: 40,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            )),
                      ),
                    ),
                    if (title != null)
                      const SizedBox(
                        height: 16,
                      ),
                    if (title != null)
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    childBuilder(context, scrollController),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}

Widget sizeW(double size) {
  return SizedBox(width: size);
}

Widget sizeH(double size) {
  return SizedBox(height: size);
}

RichText coloredText(String text) {
  final pattern = RegExp(r'\B#\w+');
  final matches = pattern.allMatches(text);

  List<TextSpan> spans = [];

  int previousMatchEnd = 0;
  for (Match match in matches) {
    if (match.start > previousMatchEnd) {
      spans.add(
        TextSpan(
          text: text.substring(previousMatchEnd, match.start),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }
    spans.add(
      TextSpan(
        text: text.substring(match.start, match.end),
        style: const TextStyle(color: Colors.blue),
      ),
    );
    previousMatchEnd = match.end;
  }

  if (previousMatchEnd < text.length) {
    spans.add(
      TextSpan(
        text: text.substring(previousMatchEnd),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  return RichText(
    text: TextSpan(
      children: spans,
    ),
  );
}

AppBar appBar(BuildContext context,
    {List<Widget>? actions, Color? color, Color? textColor, String? title}) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: SvgPicture.asset(
          'assets/ic_back.svg',
          package: 'max_splash_boarding',
          width: 30,
          height: 30,
        )),
    elevation: 0.0,
    // ignore: prefer_const_constructors
    title: Text(
      title ?? 'Moments',
      style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.bold,
          // letterSpacing: 2.0,
          fontSize: 16),
    ),
    centerTitle: true,
    foregroundColor: color ?? Colors.transparent,
    backgroundColor: color ?? Colors.transparent,
    actions: actions,
  );
}

void showToast(BuildContext context, String msg, {int? duration}) {
  GFToast.showToast(msg, context,
      toastPosition: GFToastPosition.BOTTOM,
      textStyle: const TextStyle(fontSize: 16, color: GFColors.LIGHT),
      backgroundColor: GFColors.DARK,
      toastBorderRadius: 8.0,
      toastDuration: duration,
      trailing: const Text('Tutup',
          style: TextStyle(
            color: Colors.green,
          )));
}

void showToastError(BuildContext context, String msg) {
  GFToast.showToast(msg, context,
      toastPosition: GFToastPosition.BOTTOM,
      textStyle: const TextStyle(fontSize: 16, color: GFColors.LIGHT),
      backgroundColor: Colors.red,
      toastBorderRadius: 8.0,
      trailing: const Text('Tutup',
          style: TextStyle(
            color: Colors.black,
          )));
}

String abbreviateNumber(int num) {
  if (num >= 1000000) {
    return (num / 1000000).toStringAsFixed(1) + 'm';
  } else if (num >= 1000) {
    return (num / 1000).toStringAsFixed(1) + 'k';
  } else {
    return num.toString();
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
