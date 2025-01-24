import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final bool? isRequired;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.letterSpacing,
      this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.textAlign,
      this.isRequired,
      this.overflow,
      this.fontStyle,
      this.textStyle,
      this.decoration
      });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return (isRequired ?? false)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text,
                  overflow: overflow,
                  textAlign: textAlign ?? TextAlign.start,
                  style: textStyle ??
                      TextStyle(
                        letterSpacing: letterSpacing,
                        color: color ?? Theme.of(context).colorScheme.primary,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        fontSize: fontSize ?? 14.0,
                        fontFamily: fontFamily ?? 'Helvetica',
                        fontStyle: fontStyle,
                        decoration: decoration,
                        decorationStyle: TextDecorationStyle.double
                      )),
              const SizedBox(
                width: 1.0,
              ),
              CustomText(
                text: "*",
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.error,
              ),
            ],
          )
        : Text(text,
            textAlign: textAlign ?? TextAlign.start,
            overflow: overflow,
            style: textStyle ??
                TextStyle(
                  letterSpacing: letterSpacing,
                  color: color ?? theme.colorScheme.primary,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontSize: fontSize ?? 14.0,
                  fontFamily: fontFamily ?? 'Helvetica',
                  fontStyle: fontStyle,
                  decoration: decoration
                ));
  }
}