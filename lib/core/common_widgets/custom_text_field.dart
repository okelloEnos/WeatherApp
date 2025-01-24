import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Color? filledColor;
  final Color? textColor;

  final double? fontSize;
  final String hintText;
  final double? hintFontSize;
  final Color? borderColor;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final bool? obscureText;
  final EdgeInsets? contentPadding;
  final Widget? prefix;
  final List<TextInputFormatter>? fieldFormatters;
  final bool? enableCopy;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.filledColor,
      this.fontSize,
      required this.hintText,
      this.hintFontSize,
      this.borderColor,
      this.readOnly,
      this.onTap,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines,
      this.minLines,
      this.prefix,
      this.validator,
      this.onChanged,
      this.obscureText,
      this.textColor,
      this.contentPadding,
      this.fieldFormatters,
      this.enableCopy});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      cursorColor: theme.colorScheme.tertiary.withOpacity(0.6),
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      style: TextStyle(
          color: textColor ?? Theme.of(context).colorScheme.tertiary,
          fontWeight: FontWeight.w400,
          fontSize: fontSize ?? 16.0,
          fontFamily: 'Helvetica'),
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                  child: prefixIcon,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                  child: suffixIcon,
                )
              : null,
          filled: true,
          fillColor: filledColor ?? theme.colorScheme.onPrimary,
          hintText: hintText,
          errorMaxLines: 2,
          errorStyle: TextStyle(
            fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
            fontWeight: Theme.of(context).textTheme.bodyLarge!.fontWeight,
            color: Colors.red,
          ),
          hintStyle: TextStyle(
              color: theme.hintColor,
              fontWeight: FontWeight.w400,
              fontSize: hintFontSize ?? 14.0,
              fontFamily: 'Helvetica'),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: borderColor ??
                      theme.colorScheme.tertiary.withOpacity(0.1),
                  width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: borderColor ??
                      theme.colorScheme.tertiary.withOpacity(0.1),
                  width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: borderColor ??
                      theme.colorScheme.tertiary.withOpacity(0.1),
                  width: 1)),
          prefix: prefix,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      inputFormatters: fieldFormatters,
      enableInteractiveSelection: enableCopy,
    );
  }
}
