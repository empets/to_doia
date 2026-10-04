import 'package:flutter/material.dart';
import 'package:grace_church/core/models/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onRestart;

  const TaskCard({super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onRestart});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _menuOpen = false;

  static const _primary = Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    final t = widget.task;

    return GestureDetector(
      onTap: () => setState(() => _menuOpen = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: t.done
            ? null
            : Border.all(color: _primary.withOpacity(0.08)),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10, offset: const Offset(0, 2))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Checkbox
            GestureDetector(
              onTap: widget.onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22, height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: t.done ? _primary : Colors.transparent,
                  border: Border.all(
                    color: t.done ? _primary : _primary.withOpacity(0.5),
                    width: 2)),
                child: t.done
                  ? const Icon(Icons.check_rounded,
                      color: Colors.white, size: 13)
                  : null,
              ),
            ),
            const SizedBox(width: 12),

            // Titre
            Expanded(
              child: Text(
                t.title,
                style: TextStyle(
                  color: t.done
                    ? const Color(0xFF6B7280)
                    : const Color(0xFF1A1A2E),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  decoration: t.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                  decorationColor: const Color(0xFF6B7280)),
              ),
            ),

            // Menu "···"
            GestureDetector(
              onTap: () => setState(() => _menuOpen = !_menuOpen),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.more_horiz_rounded,
                  color: Color(0xFF6B7280), size: 18)),
            ),
          ]),

          // Méta (date + heure + récurrence)
          Padding(
            padding: const EdgeInsets.only(left: 34, top: 6),
            child: Wrap(spacing: 8, children: [
              _Tag(icon: Icons.calendar_today_rounded,
                text: t.dateLabel),
              _Tag(icon: Icons.access_time_rounded,
                text: t.timeLabel),
              if (t.recurrence != 'Aucune')
                _Tag(icon: Icons.repeat_rounded,
                  text: t.recurrence, color: _primary),
              if (t.done)
                _Tag(icon: Icons.check_circle_rounded,
                  text: 'Terminée',
                  color: const Color(0xFF10B981)),
            ]),
          ),

          // Menu contextuel
          if (_menuOpen)
            Container(
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB))),
              child: Column(children: [
                if (!t.done)
                  _MenuItem(
                    icon: Icons.check_circle_outline_rounded,
                    color: const Color(0xFF10B981),
                    label: 'Marquer comme terminée',
                    onTap: () {
                      setState(() => _menuOpen = false);
                      widget.onToggle();
                    }),
                if (t.done)
                  _MenuItem(
                    icon: Icons.refresh_rounded,
                    color: _primary,
                    label: 'Réactiver la tâche',
                    onTap: () {
                      setState(() => _menuOpen = false);
                      widget.onRestart();
                    }),
                const Divider(height: 1, color: Color(0xFFE5E7EB)),
                _MenuItem(
                  icon: Icons.edit_outlined,
                  color: const Color(0xFFF59E0B),
                  label: 'Modifier',
                  onTap: () => setState(() => _menuOpen = false)),
                const Divider(height: 1, color: Color(0xFFE5E7EB)),
                _MenuItem(
                  icon: Icons.delete_outline_rounded,
                  color: const Color(0xFFEF4444),
                  label: 'Supprimer',
                  onTap: () {
                    setState(() => _menuOpen = false);
                    widget.onDelete();
                  }),
              ]),
            ),
        ]),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _Tag({required this.icon, required this.text,
    this.color = const Color(0xFF6B7280)});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 12, color: color),
      const SizedBox(width: 3),
      Text(text, style: TextStyle(color: color, fontSize: 12)),
    ],
  );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.color,
    required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Text(label,
          style: TextStyle(color: color, fontSize: 14,
            fontWeight: FontWeight.w600)),
      ]),
    ),
  );
}
