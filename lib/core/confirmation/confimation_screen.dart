// lib/screens/confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_doia/core/succes_screen/success_screen.dart';
import 'package:to_doia/feature/taches/manual_create_screen.dart';
import '../models/task.dart';

class ConfirmationScreen extends StatelessWidget {
  // final Task task;
  // final VoidCallback onConfirm;
  // final VoidCallback onModify;
  // final VoidCallback onCancel;

  ConfirmationScreen({
    super.key,
    // required this.task,
    // required this.onConfirm,
    // required this.onModify,
    // required this.onCancel
  });

  final task = Task(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: 'Appeler Jean',
    date: 'Demain',
    time: '10:00',
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.notifications_rounded,
                    color: Color(0xFF6366F1),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Nouveau rappel',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Carte de la tâche
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.roboto(
                      color: Color(0xFF1A1A2E),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _InfoRow(emoji: '📅', label: task.dateLabel),
                  const SizedBox(height: 12),
                  _InfoRow(emoji: '🕐', label: task.timeLabel),
                  const SizedBox(height: 12),
                  _InfoRow(
                    emoji: '🔁',
                    label: task.recurrence == 'Aucune'
                        ? 'Non récurrent'
                        : task.recurrence,
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Boutons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      //onModify
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManualCreateScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6366F1),
                      side: const BorderSide(
                        color: Color(0xFF6366F1),
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Modifier',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //onConfirm
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirmer',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  //onCancel
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Annuler',
                  style: GoogleFonts.roboto(
                    color: Color(0xFFEF4444),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _InfoRow extends StatelessWidget {
  final String emoji, label;
  const _InfoRow({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(emoji, style: GoogleFonts.roboto(fontSize: 18)),
      const SizedBox(width: 12),
      Text(
        label,
        style: GoogleFonts.roboto(
          color: Color(0xFF1A1A2E),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
