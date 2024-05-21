import 'package:flutter/material.dart';
import 'package:todo/new_task.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  bool isSelectionMode = false;
  List<bool> selectedTasks = [false]; 

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
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Date: May 22, 2024',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            TaskItem(
              icon: Icons.work,
              description: 'task 1 need to complete',
              isSelectionMode: isSelectionMode,
              isSelected: selectedTasks[0],
              onSelected: (selected) => updateTaskSelection(0, selected),
            ),
            Spacer(),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final IconData icon;
  final String description;
  final bool isSelectionMode;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  TaskItem({
    required this.icon,
    required this.description,
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
        trailing: isSelectionMode
            ? Checkbox(
                value: isSelected,
                onChanged: onSelected,
              )
            : null,
      ),
    );
  }
}