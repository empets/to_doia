// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grace_church/core/custome_widget/custome_text.dart';
// import 'package:grace_church/core/extension/custome_extension.dart';

// // Custome_formField
// class ProductionFormCustomer extends StatelessWidget {
//   const ProductionFormCustomer({
//     super.key,
//     this.onChanged,
//     required this.textLabel,
//     this.isCancel,
//     required this.errorText,
//     required this.msgError,
//     this.textInputType,
//     this.controller,
//     this.maxLines,
//     this.minLines,
//     this.hintStyle,
//     this.readOnly,
//     this.prefixIcon,
//     this.letSpace,
//     required this.inputLabel,
//     this.inputStyle,
//     this.sufixIcon,
//     this.isColorBlue = false,
//     this.inputLabelSize,
//     this.lable,
//   });

//   final void Function(String)? onChanged;
//   final String textLabel;
//   final String inputLabel;
//   final bool? isCancel;
//   final String? errorText;
//   final String msgError;
//   final TextInputType? textInputType;
//   final TextEditingController? controller;
//   final int? maxLines;
//   final int? minLines;
//   final TextStyle? hintStyle;
//   final TextStyle? inputStyle;
//   final bool? readOnly;
//   final Widget? prefixIcon;
//   final Widget? sufixIcon;
//   final List<TextInputFormatter>? letSpace;
//   final bool isColorBlue;
//   final double? inputLabelSize;
//   final String? lable;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           inputLabel,
//           style:
//               inputStyle ??
//               context.appTypographie.small.copyWith(
//                 color: Colors.grey.shade700,
//                 fontSize: inputLabelSize ?? 14.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         SizedBox(height: 3.h),
//         TextFormField(
//           readOnly: readOnly ?? false,
//           controller: controller,
//           minLines: minLines ?? 1,
//           maxLines: maxLines ?? 1,
//           inputFormatters:
//               letSpace ?? [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
//           keyboardType: textInputType,
//           style: GoogleFonts.roboto(color: context.appColor.primaryGrayDark),
//           decoration: InputDecoration(
//             prefixIcon: prefixIcon,
//             suffixIcon: sufixIcon,
//             label: lable != null
//                 ? Text(
//                     lable!,
//                     style:
//                         hintStyle ??
//                         GoogleFonts.roboto(
//                           color: Colors.black,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 0.5.sp,
//                         ),
//                   )
//                 : null,
//             hint: Text(
//               textLabel,
//               style:
//                   hintStyle ??
//                   GoogleFonts.roboto(
//                     color: const Color(0xFF888888),
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),
//             isDense: true, // Added this
//             contentPadding: EdgeInsets.all(14.sp),
//             filled: true,
//             //'hintText: textLabel,'
//             errorText: errorText,
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: isColorBlue
//                     ? context.appColor.primaryLightBlue
//                     : Colors.grey.withOpacity(.5),
//               ),
//               borderRadius: BorderRadius.circular(7.r),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: (isCancel != null)
//                     ? context.appColor.primaryGray100
//                     : Colors.red,
//               ),
//               borderRadius: BorderRadius.circular(7.r),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: isColorBlue
//                     ? context.appColor.primaryLightBlue
//                     : Colors.grey.withOpacity(.5),
//               ),
//               gapPadding: 2,
//               borderRadius: BorderRadius.circular(7.r),
//             ),
//             border: OutlineInputBorder(
//               gapPadding: 2,
//               borderRadius: BorderRadius.circular(7.r),
//             ),
//             errorStyle: GoogleFonts.roboto(
//               color: (isCancel != null)
//                   ? context.appColor.primaryError
//                   : Colors.red.withValues(alpha: 0.2),
//               fontWeight: FontWeight.bold,
//             ),
//             hintStyle: GoogleFonts.roboto(
//               color: const Color(0xFF888888),
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//             ),
//             fillColor: Colors.grey.shade50,
//           ),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }

// // Custome_checbox
// class CustomSelectableTile extends StatelessWidget {
//   CustomSelectableTile({
//     super.key,
//     required this.title,
//     required this.isChecked,
//     required this.onChanged,
//     this.readOnly = false,
//   });
//   final String title;
//   final bool isChecked;
//   final ValueChanged<bool> onChanged;
//   late bool readOnly;

//   @override
//   Widget build(BuildContext context) {
//     final appColor = context.appColor;

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4.h),
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isChecked ? appColor.primaryBlue : Colors.grey.withOpacity(.5),
//         ),
//         borderRadius: BorderRadius.circular(10.r),
//       ),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8.h),
//         child: Row(
//           children: [
//             /// Texte
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w700,
//                   color: appColor.primaryGrayDark,
//                 ),
//               ),
//             ),

//             SizedBox(width: 10.w),

//             /// Checkbox custom
//             GestureDetector(
//               onTap: readOnly ? null : () => onChanged(!isChecked),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 height: 24.h,
//                 width: 24.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(6.r),
//                   color: isChecked ? appColor.primaryBlue : Colors.transparent,
//                   border: Border.all(
//                     color: isChecked
//                         ? appColor.primaryBlue
//                         : Colors.grey.withOpacity(.5),
//                     width: 2,
//                   ),
//                   boxShadow: isChecked
//                       ? [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.3),
//                             blurRadius: 6,
//                             offset: const Offset(0, 3),
//                           ),
//                         ]
//                       : [],
//                 ),
//                 child: isChecked
//                     ? const Icon(Icons.check, size: 18, color: Colors.white)
//                     : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //Custome_dropdown
// class CustomDropdown extends StatelessWidget {
//   CustomDropdown({
//     super.key,
//     required this.hint,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.icons,
//     this.readOnly = false,
//   });
//   final String hint;
//   final String? value;
//   final List<Map<String, dynamic>> items;
//   final ValueChanged<String?> onChanged;
//   final IconData? icons;
//   late bool readOnly;

//   @override
//   Widget build(BuildContext context) {
//     final appColor = context.appColor;

//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         isExpanded: true,
//         dropdownColor: appColor.primaryWhite,
//         hint: Text(
//           hint,
//           style: GoogleFonts.roboto(color: Colors.grey, fontSize: 14.sp),
//         ),
//         value: value,
//         style: GoogleFonts.roboto(color: Colors.black, fontSize: 14.sp),
//         icon: Icon(icons ?? Icons.keyboard_arrow_down),
//         items: items
//             .map(
//               (item) => DropdownMenuItem<String>(
//                 value: item["label"],
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 9.h),
//                     Text(
//                       item["label"] ?? "",
//                       style: GoogleFonts.roboto(
//                         color: Colors.black,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                     if (item["sublabel"] != null &&
//                         item["sublabel"].toString().trim().isNotEmpty)
//                       Text(
//                         item["sublabel"] ?? "",
//                         style: GoogleFonts.roboto(
//                           color: Colors.grey,
//                           fontSize: 0.sp,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//         onChanged: readOnly ? null : onChanged,
//       ),
//     );
//   }
// }

// class FormNextTeps extends StatelessWidget {
//   const FormNextTeps({
//     super.key,
//     required this.icons,
//     required this.title,
//     required this.description,
//     required this.isNextForm,
//   });

//   final IconData icons;
//   final String title;
//   final String description;
//   final bool isNextForm;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 10.w),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: context.appColor.primaryGray500.withValues(alpha: 0.2),
//         ),
//         color: context.appColor.primaryWhite,
//         borderRadius: BorderRadius.circular(7.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
//                 decoration: BoxDecoration(
//                   color: isNextForm
//                       ? context.appColor.primaryLightBlue
//                       : context.appColor.primaryGray100,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   icons,
//                   color: isNextForm
//                       ? context.appColor.primaryGray700.withValues(alpha: 0.5)
//                       : context.appColor.primaryGray700.withValues(alpha: 0.1),
//                 ),
//               ),

//               Container(
//                 margin: EdgeInsets.only(left: 14.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomeText(
//                       text: title,
//                       style: context.appTypographie.body.copyWith(
//                         fontSize: 13.sp,
//                         color: isNextForm
//                             ? Colors.grey.shade700
//                             : Colors.grey.shade200,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     CustomeText(
//                       text: description,
//                       style: context.appTypographie.small.copyWith(
//                         fontSize: 11.5.sp,
//                         color: isNextForm
//                             ? Colors.grey.shade500
//                             : Colors.grey.shade200,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           Container(
//             margin: EdgeInsets.only(top: 6.h),
//             child: Icon(
//               isNextForm ? Icons.lock_open_rounded : Icons.lock,
//               color: isNextForm
//                   ? context.appColor.primaryWhite
//                   : context.appColor.primaryGray500.withValues(alpha: 0.1),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomeTextFormFieldWithoutBorder extends StatelessWidget {
//   const CustomeTextFormFieldWithoutBorder({
//     super.key,
//     this.onChanged,
//     required this.textLabel,
//     this.isCancel,
//     required this.errorText,
//     required this.msgError,
//     this.textInputType,
//     this.controller,
//     this.maxLines,
//     this.minLines,
//     this.hintStyle,
//     this.readOnly,
//     this.prefixIcon,
//     this.letSpace,
//     required this.inputLabel,
//     this.inputStyle,
//     this.sufixIcon,
//     this.isColorBlue = false,
//     this.inputLabelSize,
//   });

//   final void Function(String)? onChanged;
//   final String textLabel;
//   final String inputLabel;
//   final bool? isCancel;
//   final String? errorText;
//   final String msgError;
//   final TextInputType? textInputType;
//   final TextEditingController? controller;
//   final int? maxLines;
//   final int? minLines;
//   final TextStyle? hintStyle;
//   final TextStyle? inputStyle;
//   final bool? readOnly;
//   final Widget? prefixIcon;
//   final Widget? sufixIcon;
//   final List<TextInputFormatter>? letSpace;
//   final bool isColorBlue;
//   final double? inputLabelSize;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           inputLabel,
//           style:
//               inputStyle ??
//               context.appTypographie.small.copyWith(
//                 color: Colors.grey.shade700,
//                 fontSize: inputLabelSize ?? 14.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         SizedBox(height: 3.h),
//         TextFormField(
//           readOnly: readOnly ?? false,
//           controller: controller,
//           minLines: minLines ?? 1,
//           maxLines: maxLines ?? 1,
//           inputFormatters:
//               letSpace ?? [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
//           keyboardType: textInputType,
//           style: GoogleFonts.roboto(color: context.appColor.primaryGrayDark),
//           decoration: InputDecoration(
//             prefixIcon: prefixIcon,
//             suffixIcon: sufixIcon,
//             hint: Text(
//               textLabel,
//               style:
//                   hintStyle ??
//                   GoogleFonts.roboto(
//                     color: const Color(0xFF888888),
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//             ),

//             isDense: true,
//             contentPadding: EdgeInsets.symmetric(vertical: 12.sp),

//             filled: false, // ❗ important pour enlever le fond
//             // errorText: errorText,
//             error: errorText != null
//                 ? Text(
//                     errorText!,
//                     style: GoogleFonts.roboto(
//                       color: (isCancel != null)
//                           ? context.appColor.primaryError
//                           : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 : null,

//             // ✅ Bordure normale
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
//             ),

//             // ✅ Bordure focus
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: isColorBlue
//                     ? context.appColor.primaryLightBlue
//                     : Colors.grey.withValues(alpha: 0.5),
//                 width: 2,
//               ),
//             ),

//             // ✅ Bordure erreur
//             errorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.5)),
//             ),

//             focusedErrorBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.red.withValues(alpha: 0.5),
//                 width: 2,
//               ),
//             ),

//             // ❌ supprimer les autres borders
//             border: UnderlineInputBorder(),
//           ),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }
