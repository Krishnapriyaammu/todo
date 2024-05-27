import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/new_task.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
   bool isSelectionMode = false;
  List<bool> selectedTasks = [];

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
    });
  }

  void updateTaskSelection(int index, bool? selected) {
    setState(() {
      selectedTasks[index] = selected ?? false;
    });
  }

  void performActionOnSelectedTasks(String action) {
    print(action);
    toggleSelectionMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Tasks'),
        actions: [
          TextButton(
            onPressed: toggleSelectionMode,
            child: Text(
              isSelectionMode ? 'Cancel' : 'Select',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          if (isSelectionMode) ...[
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.orange),
              onPressed: () => performActionOnSelectedTasks('Today'),
            ),
            IconButton(
              icon: Icon(Icons.calendar_view_day, color: Colors.orange),
              onPressed: () => performActionOnSelectedTasks('Tomorrow'),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => performActionOnSelectedTasks('Delete'),
            ),
          ],
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No tasks available'));
            }

            final tasks = snapshot.data!.docs;
            selectedTasks = List<bool>.filled(tasks.length, false);

            final firstTask = tasks.first.data() as Map<String, dynamic>;
            final firstTaskDate = firstTask['date'] != null
                ? (firstTask['date'] as Timestamp).toDate()
                : DateTime.now();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Date: ${firstTaskDate.day}/${firstTaskDate.month}/${firstTaskDate.year}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final taskData = task.data() as Map<String, dynamic>;

                      return TaskItem(
                        icon: Icons.work,
                        description: taskData['title'] ?? 'No description',
                        category: taskData['category'] ?? 'No category',
                        date: taskData['date'] != null
                            ? (taskData['date'] as Timestamp).toDate()
                            : DateTime.now(),
                        isSelectionMode: isSelectionMode,
                        isSelected: selectedTasks[index],
                        onSelected: (selected) => updateTaskSelection(index, selected),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16), 
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewTask()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text('New Task'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String description;
  final String category;
  final DateTime date;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  TaskItem({
    required this.icon,
    required this.description,
    required this.category,
    required this.date,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(description),
        subtitle: Text(category),
        trailing: isSelectionMode
            ? Checkbox(
                value: isSelected,
                onChanged: onSelected,
              )
            : Text(
                "${date.day}/${date.month}/${date.year}",
                style: TextStyle(color: Colors.grey),
              ),
      ),
    );
  }
}