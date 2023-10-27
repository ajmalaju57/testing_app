import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_eco/ui/components/app_svg.dart';
import 'package:test_eco/ui/components/app_text.dart';
import 'package:test_eco/utils/extensions/margin_ext.dart';
import 'package:test_eco/utils/extensions/string_ext.dart';
import 'package:test_eco/utils/shared/fns.dart';
import 'package:test_eco/utils/strings.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      this.hint,
      this.controller,
      required this.label,
      this.obscureText = false,
      this.onTap,
      this.suffixIcon,
      this.isMultiline = false,
      this.prefixIcon,
      this.validator,
      this.helperText,
      this.maxLength = 100,
      this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      this.textInputAction = TextInputAction.next,
      this.shadowOpacity = 0.03,
      this.isOutline = true,
      this.isBorderNeeded = true,
      this.isAddField = false,
      this.maxLines = 1,
      this.isAddOrMinusIcon})
      : super(key: key);

  final String? hint, helperText;
  final String label;
  final TextEditingController? controller;
  final bool obscureText, isBorderNeeded;
  final void Function()? onTap;
  final Widget? suffixIcon, isAddOrMinusIcon, prefixIcon;
  final int? maxLength;

  final String? Function(String value)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final double shadowOpacity;
  final bool isOutline, isMultiline;
  final bool isAddField;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isBorderNeeded ? 12.hBox : 4.hBox,
        label.isNotEmpty
            ? AppText(
                label.upperFirst,
                color: Colors.grey.shade600,
                family: inter500,
                size: 12,
              )
            : 0.hBox,
        isBorderNeeded ? 8.hBox : 4.hBox,
        Container(
          decoration: isBorderNeeded ? BoxDecoration(boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12.withOpacity(shadowOpacity))], borderRadius: BorderRadius.circular(8)) : null,
          child: onTap != null
              ? !isAddField
                  ? InkWell(
                      onTap: () {
                        hideKeyboard;
                        onTap!();
                      },
                      child: IgnorePointer(ignoring: true, child: _buildTextFormField()))
                  : _buildTextFormField()
              : onTap != null
                  ? IgnorePointer(ignoring: true, child: _buildTextFormField())
                  : _buildTextFormField(),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        controller: controller,
        obscureText: obscureText,
        readOnly: !isAddField ? onTap != null : true,
        style: const TextStyle(fontSize: 14),
        maxLines: isMultiline ? 5 : 1,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        validator: (value) => validator != null ? validator!(value ?? '') : null,
        // maxLines: maxLines,
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 11, height: 1),
            helperStyle: const TextStyle(fontSize: 11, height: 1),
            hintText: hint?.upperFirst,
            hintStyle: const TextStyle(
              color: Color(0xFF667085),
              fontFamily: inter400,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(13.0),
              child: suffixIcon ??
                  (onTap != null
                      ? isAddField
                          ? GestureDetector(
                              onTap: () {
                                hideKeyboard;
                                onTap!();
                              },
                              child: isAddOrMinusIcon)
                          : const AppSvg(assetName: "arrow-down")
                      : null),
            ),
            fillColor: Colors.white,
            filled: true,
            helperText: helperText?.upperFirst,
            contentPadding: isBorderNeeded ? const EdgeInsets.symmetric(horizontal: 16, vertical: 10) : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            border: _border(),
            enabledBorder: isBorderNeeded ? _border() : _underLine(),
            focusedBorder: isBorderNeeded ? _border() : _underLine(),
            disabledBorder: _border(),
            focusedErrorBorder: _border(borderClr: Colors.red),
            errorBorder: _border(borderClr: Colors.red),
            isDense: isBorderNeeded ? false : true));
  }

  InputBorder _border({Color borderClr = Colors.grey}) {
    //300
    return isOutline
        ? OutlineInputBorder(borderSide: BorderSide(color: borderClr), borderRadius: BorderRadius.circular(8))
        : const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)); //600
  }

  UnderlineInputBorder _underLine({Color borderClr = Colors.black26}) {
    return UnderlineInputBorder(borderSide: BorderSide(color: borderClr));
  }
}
