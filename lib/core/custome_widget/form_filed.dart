import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductionFormCustomer extends StatelessWidget {
  const ProductionFormCustomer({
    super.key,
    this.onChanged,
    required this.textLabel,
    this.isCancel,
    required this.errorText,
    required this.msgError,
    this.textInputType,
    this.controller,
    this.maxLines,
    this.minLines,
    this.hintStyle,
    this.readOnly,
    this.prefixIcon,
    this.letSpace,
    required this.inputLabel,
    this.inputStyle,
    this.sufixIcon,
    this.isColorBlue = false,
    this.inputLabelSize,
    this.lable,
    this.fillColor,
    this.focusNode,
    this.autofocus = false,
    this.borderRaduis,
  });

  final void Function(String)? onChanged;
  final String textLabel;
  final String inputLabel;
  final bool? isCancel;
  final String? errorText;
  final String msgError;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final List<TextInputFormatter>? letSpace;
  final bool isColorBlue;
  final double? inputLabelSize;
  final String? lable;
  final Color? fillColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final double? borderRaduis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (inputLabel.trim().isNotEmpty)
          Text(
            inputLabel,
            style:
                inputStyle ??
                GoogleFonts.roboto(
                  color: Colors.grey.shade700,
                  fontSize: inputLabelSize ?? 14.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
        SizedBox(height: 3.h),
        TextFormField(
          autofocus: autofocus,
          focusNode: focusNode,
          readOnly: readOnly ?? false,
          controller: controller,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          inputFormatters:
              letSpace ?? [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          keyboardType: textInputType,
          textInputAction: TextInputAction.newline,
          style: GoogleFonts.roboto(color: Colors.grey.shade700),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
            label: lable != null
                ? Text(
                    lable!,
                    style:
                        hintStyle ??
                        GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5.sp,
                        ),
                  )
                : null,
            hint: Text(
              textLabel,
              style:
                  hintStyle ??
                  GoogleFonts.roboto(
                    color: const Color(0xFF888888),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            isDense: true, // Added this
            contentPadding: EdgeInsets.all(14.sp),
            filled: true,
            //'hintText: textLabel,'
            errorText: errorText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: .5)),
              borderRadius: BorderRadius.circular(borderRaduis ?? 10.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(borderRaduis ?? 10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withValues(alpha: .5)),
              gapPadding: 2,
              borderRadius: BorderRadius.circular(borderRaduis ?? 10.r),
            ),
            border: OutlineInputBorder(
              gapPadding: 2,
              borderRadius: BorderRadius.circular(borderRaduis ?? 10.r),
            ),
            errorStyle: GoogleFonts.roboto(
              color: Colors.red.withValues(alpha: 0.9),
              fontWeight: FontWeight.bold,
            ),
            hintStyle: GoogleFonts.roboto(
              color: const Color(0xFF888888),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            fillColor: fillColor ?? Colors.grey.shade50,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
