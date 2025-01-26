import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core_barrel.dart';
import '../values/values_barrel.dart';

class CustomElevatedButton extends StatelessWidget {
  final String btnText;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool disabled;
  final Color? btnColor;
  final Color? textColor;
  final double? textFontSize;
  final bool isLoading;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final double? radius;
  final Size? btnSize;
  final double? elevation;

  const CustomElevatedButton(
      {super.key,
        required this.btnText,
        required this.onPressed,
        this.disabled = false,
        this.icon,
        this.btnColor,
        this.textColor,
        this.textFontSize,
        this.isLoading = false,
        this.padding,
        this.radius,
        this.fontWeight,
        this.btnSize,
        this.elevation});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      onPressed: disabled
          ? null
          : () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: btnSize ?? const Size(double.infinity, kIsWeb ? 50 : 50.0),
        foregroundColor: textColor ?? theme.colorScheme.primary,
        backgroundColor: btnColor ?? theme.colorScheme.onPrimary,
        padding: padding,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
      ),
      child: Center(
          child: CustomText(
              text: btnText,
              textAlign: TextAlign.center,
              fontSize: textFontSize ?? 14,
              color: theme.colorScheme.primary,
              fontWeight: fontWeight)),
    );
  }
}