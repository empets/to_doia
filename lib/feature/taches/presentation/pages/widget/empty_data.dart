import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyTaskState extends StatelessWidget {
  final VoidCallback onTapMic;
  final bool isRefreshing;
  final VoidCallback onRefresh;

  const EmptyTaskState({
    super.key,
    required this.onTapMic,
    required this.isRefreshing,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('📋', style: TextStyle(fontSize: 52)),
        const SizedBox(height: 14),
        Text(
          'Aucune tâche trouvée suite à votre recherche',
          style: GoogleFonts.roboto(
            color: Color(0xFF1A1A2E),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        if (isRefreshing) ...[
          GestureDetector(
            onTap: onRefresh,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Rafraîchir',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
        ],
        GestureDetector(
          onTap: onTapMic,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isRefreshing ? Color(0xFF6366F1) : Colors.transparent,
              ),
              color: isRefreshing
                  ? Colors.transparent
                  : const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mic_rounded, color: Colors.black, size: 18),
                SizedBox(width: 8),
                Text(
                  'Créer une nouvelle tâche',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 14.h),
      ],
    ),
  );
}

class SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final bool isHome;
  final void Function()? onPressed;
  const SectionHeader({
    super.key,
    required this.title,
    required this.count,
    this.isHome = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 4),
    child: Row(
      children: [
        if (isHome) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  "Aujourd'hui",
                  style: GoogleFonts.roboto(
                    color: Color(0xFF1A1A2E),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  'Voir tout',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF6366F1),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
        if (!isHome) ...[
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Color(0xFF6366F1),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class IconBtn extends StatelessWidget {
  final IconData icon;
  final bool active, primary;
  final VoidCallback onTap;
  const IconBtn({
    super.key,
    required this.icon,
    required this.onTap,
    this.active = false,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: primary || active
            ? const Color(0xFF6366F1)
            : const Color(0xFF6366F1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: primary || active ? Colors.white : const Color(0xFF6366F1),
        size: 20,
      ),
    ),
  );
}

class Label extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const Label(this.text, {super.key, this.style});
  @override
  Widget build(BuildContext context) => Text(
    text,
    style:
        style ??
        GoogleFonts.roboto(
          color: Color(0xFF6B7280),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
  );
}

class FieldBox extends StatelessWidget {
  final IconData icon;
  final String text;
  const FieldBox({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF6366F1), size: 17),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF1A1A2E), fontSize: 13),
        ),
      ],
    ),
  );
}
