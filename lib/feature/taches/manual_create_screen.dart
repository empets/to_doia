// lib/screens/manual_create_screen.dart
import 'package:flutter/material.dart';
import 'package:to_doia/core/models/task.dart';
import 'package:to_doia/core/voice/voice_listening.dart'
    show VoiceListeningScreen;

class ManualCreateScreen extends StatefulWidget {
  const ManualCreateScreen({super.key});
  @override
  State<ManualCreateScreen> createState() => _ManualCreateScreenState();
}

class _ManualCreateScreenState extends State<ManualCreateScreen> {
  final _titleCtrl = TextEditingController();
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  String _rec = 'Aucune';

  static const _primary = Color(0xFF6366F1);
  bool get _canSave => _titleCtrl.text.trim().isNotEmpty;

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  final task = Task(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: 'Appeler Jean',
    date: 'Demain',
    time: '10:00',
  );

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F6FB),
    body: SafeArea(
      child: Column(
        children: [
          // ── Header ───────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    //widget.onBack
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: _primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  'Nouvelle tâche',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Conseil vocal
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.mic_rounded,
                          color: _primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Conseil : utilisez votre voix !',
                                style: TextStyle(
                                  color: _primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Plus rapide avec le microphone.',
                                style: TextStyle(
                                  color: _primary.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Titre
                _Label('TITRE DE LA TÂCHE'),
                const SizedBox(height: 6),
                TextField(
                  controller: _titleCtrl,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ex : Appeler Jean...',
                    hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Date + Heure
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Label('DATE'),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: _pickDate,
                            child: _FieldBox(
                              icon: Icons.calendar_today_rounded,
                              text: '${_date.day}/${_date.month}/${_date.year}',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Label('HEURE'),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: _pickTime,
                            child: _FieldBox(
                              icon: Icons.access_time_rounded,
                              text: _time.format(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Répétition
                _Label('RÉPÉTITION'),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _rec,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 14,
                      ),
                      items: ['Aucune', 'Quotidien', 'Hebdomadaire', 'Mensuel']
                          .map(
                            (v) => DropdownMenuItem(value: v, child: Text(v)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _rec = v!),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Bouton créer
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canSave
                        ? () {
                            Task(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              title: _titleCtrl.text.trim(),
                              date: '${_date.day}/${_date.month}',
                              time: _time.format(context),
                            );
                            // widget.onAdd(Task(
                            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
                            //   title: _titleCtrl.text.trim(),
                            //   date: '${_date.day}/${_date.month}',
                            //   time: _time.format(context),
                            //   recurrence: _rec,
                            // ));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      disabledBackgroundColor: _primary.withOpacity(0.4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Créer la tâche',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
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

class _FieldBox extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FieldBox({required this.icon, required this.text});
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
