// lib/screens/tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:grace_church/core/models/task.dart';
import 'package:grace_church/feature/taches/task_card.dart';


class TasksScreen extends StatefulWidget {
  final List<Task> tasks;
  final void Function(String) onToggle;
  final void Function(String) onDelete;
  final void Function(Task) onRestart;
  final VoidCallback onMicTap;
  final VoidCallback onAddManual;
  final bool showCompleted;

  const TasksScreen({super.key,
    required this.tasks, required this.onToggle,
    required this.onDelete, required this.onRestart,
    required this.onMicTap, required this.onAddManual,
    this.showCompleted = true});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _filter = 'Toutes';
  String _search = '';
  bool _searchOpen = false;
  final _filters = ['Toutes', 'À faire', 'Terminées', "Aujourd'hui", 'À venir'];

  List<Task> get _filtered {
    var list = widget.tasks;
    if (_search.isNotEmpty) {
      list = list.where((t) =>
        t.title.toLowerCase().contains(_search.toLowerCase())).toList();
    }
    switch (_filter) {
      case 'À faire': return list.where((t) => !t.done).toList();
      case 'Terminées': return list.where((t) => t.done).toList();
      case "Aujourd'hui": return list.where((t) => !t.done && t.dateLabel == "Aujourd'hui").toList();
      case 'À venir': return list.where((t) => !t.done && t.dateLabel != "Aujourd'hui").toList();
      default: return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _filtered;
    final today    = tasks.where((t) => !t.done && t.dateLabel == "Aujourd'hui").toList();
    final tomorrow = tasks.where((t) => !t.done && t.dateLabel == 'Demain').toList();
    final upcoming = tasks.where((t) => !t.done && t.dateLabel != "Aujourd'hui" && t.dateLabel != 'Demain').toList();
    final done     = widget.showCompleted ? tasks.where((t) => t.done).toList() : <Task>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: Column(children: [
          // ── Header ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(children: [
              const Expanded(
                child: Text('Mes Tâches',
                  style: TextStyle(
                    color: Color(0xFF1A1A2E), fontSize: 24,
                    fontWeight: FontWeight.w800))),
              _IconBtn(
                icon: _searchOpen ? Icons.close_rounded : Icons.search_rounded,
                active: _searchOpen,
                onTap: () => setState(() {
                  _searchOpen = !_searchOpen;
                  if (!_searchOpen) _search = '';
                }),
              ),
              const SizedBox(width: 8),
              _IconBtn(
                icon: Icons.add_rounded, primary: true,
                onTap: widget.onAddManual),
            ]),
          ),

          // ── Recherche ───────────────────────────────────────────────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: _searchOpen
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8)]),
                    child: Row(children: [
                      const Icon(Icons.search_rounded,
                        color: Color(0xFF6366F1), size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: TextField(
                        onChanged: (v) => setState(() => _search = v),
                        style: const TextStyle(
                          color: Color(0xFF1A1A2E), fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Rechercher une tâche...',
                          hintStyle: TextStyle(color: Color(0xFF6B7280)),
                          border: InputBorder.none,
                          contentPadding:
                            EdgeInsets.symmetric(vertical: 14)),
                      )),
                    ]),
                  ))
              : const SizedBox(),
          ),

          // ── Filtres ─────────────────────────────────────────────────────────
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              children: _filters.map((f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _filter == f
                        ? const Color(0xFF6366F1) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6)]),
                    child: Text(f,
                      style: TextStyle(
                        color: _filter == f
                          ? Colors.white : const Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
                  ),
                ),
              )).toList(),
            ),
          ),

          // ── Liste ───────────────────────────────────────────────────────────
          Expanded(child: tasks.isEmpty
            ? _EmptyTaskState(onMic: widget.onMicTap)
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  if (today.isNotEmpty) ...[
                    _SectionHeader(title: "Aujourd'hui", count: today.length),
                    ...today.map((t) => TaskCard(
                      task: t,
                      onToggle: () => widget.onToggle(t.id),
                      onDelete: () => widget.onDelete(t.id),
                      onRestart: () => widget.onRestart(t))),
                    const SizedBox(height: 12),
                  ],
                  if (tomorrow.isNotEmpty) ...[
                    _SectionHeader(title: 'Demain', count: tomorrow.length),
                    ...tomorrow.map((t) => TaskCard(
                      task: t,
                      onToggle: () => widget.onToggle(t.id),
                      onDelete: () => widget.onDelete(t.id),
                      onRestart: () => widget.onRestart(t))),
                    const SizedBox(height: 12),
                  ],
                  if (upcoming.isNotEmpty) ...[
                    _SectionHeader(title: 'À venir', count: upcoming.length),
                    ...upcoming.map((t) => TaskCard(
                      task: t,
                      onToggle: () => widget.onToggle(t.id),
                      onDelete: () => widget.onDelete(t.id),
                      onRestart: () => widget.onRestart(t))),
                    const SizedBox(height: 12),
                  ],
                  if (done.isNotEmpty) ...[
                    _SectionHeader(title: 'Terminées', count: done.length),
                    ...done.map((t) => TaskCard(
                      task: t,
                      onToggle: () => widget.onToggle(t.id),
                      onDelete: () => widget.onDelete(t.id),
                      onRestart: () => widget.onRestart(t))),
                  ],
                ],
              ),
          ),
        ]),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10, top: 4),
    child: Row(children: [
      Text(title,
        style: const TextStyle(
          color: Color(0xFF1A1A2E), fontSize: 15,
          fontWeight: FontWeight.w700)),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withOpacity(0.12),
          borderRadius: BorderRadius.circular(10)),
        child: Text('$count',
          style: const TextStyle(
            color: Color(0xFF6366F1), fontSize: 11,
            fontWeight: FontWeight.w700))),
    ]),
  );
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final bool active, primary;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap,
    this.active = false, this.primary = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        color: primary || active
          ? const Color(0xFF6366F1)
          : const Color(0xFF6366F1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12)),
      child: Icon(icon,
        color: primary || active ? Colors.white : const Color(0xFF6366F1),
        size: 20)),
  );
}

class _EmptyTaskState extends StatelessWidget {
  final VoidCallback onMic;
  const _EmptyTaskState({required this.onMic});

  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('📋', style: TextStyle(fontSize: 52)),
      const SizedBox(height: 14),
      const Text('Aucune tâche',
        style: TextStyle(color: Color(0xFF1A1A2E),
          fontSize: 16, fontWeight: FontWeight.w600)),
      const SizedBox(height: 20),
      GestureDetector(onTap: onMic,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(32)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.mic_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Créer une tâche',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
        )),
    ],
  ));
}