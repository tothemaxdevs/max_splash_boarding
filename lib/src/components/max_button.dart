import 'package:flutter/material.dart';

class MaxButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? heigth;
  final double? borderRadius;
  final double? textSize;
  final double? margin;
  final FontWeight? fontWeight;

  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const MaxButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color,
      this.padding,
      this.textColor,
      this.width,
      this.heigth,
      this.isLoading = false,
      this.borderRadius,
      this.borderColor,
      this.textSize,
      this.fontWeight,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin ?? 0),
      height: heigth,
      width: width,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? const Color(0xFFFFC700),
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 10))),
        child: ElevatedButton(
            onPressed: !isLoading ? press : null,
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(
                    padding ?? const EdgeInsets.all(16)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xFFDCDEE0);
                    } else if (states.contains(MaterialState.disabled)) {
                      return const Color(0xFFF2F2F5);
                    } else if (states.contains(MaterialState.focused)) {
                      return Colors.transparent;
                    }
                    return color ??
                        Colors.transparent; // Use the component's default.
                  },
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                    color: textColor ?? Color(0xFF242632), fontSize: textSize)),
                shape:
                    MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                        (states) {
                  return RoundedRectangleBorder(
                      side: !(states.contains(MaterialState.pressed))
                          ? BorderSide(color: borderColor ?? Colors.transparent)
                          : const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(borderRadius ?? 10));
                })),
            child: Text(
              isLoading ? 'Memuat...' : text,
              style: TextStyle(
                  color: textColor ?? Colors.black,
                  fontSize: textSize ?? 14,
                  fontWeight: fontWeight ?? FontWeight.w500),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
