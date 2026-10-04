import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeText extends StatelessWidget {
  const CustomeText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,

  });

  final String text;
  final TextStyle style;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: textAlign,);
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final bool isReadMore;

  const ExpandableText({super.key, required this.text, required this.maxLines,  this.isReadMore = true});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: expanded ? null : widget.maxLines,
          overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ),
        if (widget.isReadMore) ...[
            GestureDetector(
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
          child: Text(
            expanded ? "Réduire" : "Lire la suite",
            style:  GoogleFonts.roboto(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
            ),
          ),
        ),
          
        ]
      ],
    );
  }
}
