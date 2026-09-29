import 'package:flutter/material.dart';
import 'package:jarve_j/core/constants/jarvis_colors.dart';
import 'package:jarve_j/widgets/futuristic_card.dart';

class JarvisTask {
  final String id;
  final String title;
  final String category;
  final String priority;
  bool isCompleted;

  JarvisTask({
    required this.id,
    required this.title,
    required this.category,
    required this.priority,
    this.isCompleted = false,
  });
}

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  final List<JarvisTask> _tasks = [
    JarvisTask(
      id: '1',
      title: 'Practice Java Collections & Generics',
      category: 'STUDY',
      priority: 'HIGH',
      isCompleted: false,
    ),
    JarvisTask(
      id: '2',
      title: 'Review Operating Systems process scheduling',
      category: 'STUDY',
      priority: 'MEDIUM',
      isCompleted: false,
    ),
    JarvisTask(
      id: '3',
      title: 'Configure JARVIS Phase 2 AI Tool Engine',
      category: 'CODING',
      priority: 'HIGH',
      isCompleted: true,
    ),
    JarvisTask(
      id: '4',
      title: 'Set up local SQLite memory vault',
      category: 'SYSTEM',
      priority: 'LOW',
      isCompleted: false,
    ),
  ];

  void _addNewTask() {
    final titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: JarvisColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: JarvisColors.cyan),
          ),
          title: const Text(
            'NEW TASK DIRECTIVE',
            style: TextStyle(
              color: JarvisColors.cyan,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          content: TextField(
            controller: titleController,
            style: const TextStyle(color: JarvisColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Enter task description...',
              hintStyle: TextStyle(color: JarvisColors.textMuted),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: JarvisColors.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: JarvisColors.cyan),
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  setState(() {
                    _tasks.insert(
                      0,
                      JarvisTask(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text.trim(),
                        category: 'GENERAL',
                        priority: 'MEDIUM',
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('SAVE TASK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: JarvisColors.backgroundSurface.withOpacity(0.9),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.assignment_outlined, color: JarvisColors.cyan, size: 20),
            SizedBox(width: 8),
            Text(
              'TASK SCHEDULER',
              style: TextStyle(
                color: JarvisColors.cyan,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: JarvisColors.cyan),
            onPressed: _addNewTask,
            tooltip: 'Add New Task',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: FuturisticCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    activeColor: JarvisColors.cyan,
                    checkColor: Colors.black,
                    side: const BorderSide(color: JarvisColors.borderLight, width: 1.5),
                    onChanged: (val) {
                      setState(() {
                        task.isCompleted = val ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            color: task.isCompleted ? JarvisColors.textMuted : JarvisColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _buildBadge(task.category, JarvisColors.electricBlue),
                            const SizedBox(width: 6),
                            _buildBadge(
                              task.priority,
                              task.priority == 'HIGH'
                                  ? JarvisColors.red
                                  : task.priority == 'MEDIUM'
                                      ? JarvisColors.amber
                                      : JarvisColors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18, color: JarvisColors.textMuted),
                    onPressed: () {
                      setState(() {
                        _tasks.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: JarvisColors.cyan,
        foregroundColor: Colors.black,
        onPressed: _addNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
