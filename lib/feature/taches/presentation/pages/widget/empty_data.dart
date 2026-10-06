import 'package:flutter/material.dart';

class EmptyTaskState extends StatelessWidget {
  final VoidCallback onTapMic;
  const EmptyTaskState({required this.onTapMic});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('📋', style: TextStyle(fontSize: 52)),
        const SizedBox(height: 14),
        const Text(
          'Aucune tâche',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: onTapMic,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.mic_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'Créer une tâche',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}




class SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 4),
    child: Row(
      children: [
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
    ),
  );
}

class IconBtn extends StatelessWidget {
  final IconData icon;
  final bool active, primary;
  final VoidCallback onTap;
  const IconBtn({
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
  const Label(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
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
  const FieldBox({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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