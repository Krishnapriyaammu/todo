import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/new_task.dart';

class FocusNowPage extends StatefulWidget {
  const FocusNowPage({super.key});

  @override
  State<FocusNowPage> createState() => _FocusNowPageState();
}

class _FocusNowPageState extends State<FocusNowPage> {
  @override
   Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return InitialView();
        }
        return TaskTabsView();
      },
    );
  }
}

class InitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Focus Now')),
        actions: [
        
         
         
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 16),
              Image.asset(
                'image/check.png', // Add your image to the assets folder
                height: 100,
              ),
              SizedBox(height: 16),
              Text(
                "Don't Hesitate, Take Small Steps:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TaskStep(
                icon: Icons.check_circle,
                text: 'Write down your (maximum 6) most important tasks',
              ),
              TaskStep(
                icon: Icons.check_circle,
                text: 'Prioritize tasks from most to least important',
              ),
              TaskStep(
                icon: Icons.check_circle,
                text: 'Start completing your list from the top down.',
              ),
              SizedBox(height: 16),
              Text(
                'Eliminate Distractions By Set Limited Task & See The Change!',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
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
      ),
    );
  }
}

class TaskStep extends StatelessWidget {
  final IconData icon;
  final String text;

  TaskStep({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.orange,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class TaskTabsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Focus Now')),
          actions: [
           
           
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Tomorrow'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskList(dateFilter: 'today'),
            TaskList(dateFilter: 'tomorrow'),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final String dateFilter;

  TaskList({required this.dateFilter});

  DateTime getFilterDate() {
    DateTime now = DateTime.now();
    if (dateFilter == 'tomorrow') {
      return now.add(Duration(days: 1));
    }
    return now;
  }

  @override
  Widget build(BuildContext context) {
    DateTime filterDate = getFilterDate();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No tasks available'));
        }

        List<DocumentSnapshot> tasks = snapshot.data!.docs;
        List<DocumentSnapshot> filteredTasks = tasks.where((task) {
          DateTime taskDate = (task['date'] as Timestamp).toDate();
          return taskDate.year == filterDate.year &&
              taskDate.month == filterDate.month &&
              taskDate.day == filterDate.day;
        }).toList();

        if (filteredTasks.isEmpty) {
          return Center(child: Text('No tasks for $dateFilter'));
        }

        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            var taskData = filteredTasks[index].data() as Map<String, dynamic>;
            return Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.orange),
                title: Text(taskData['title'] ?? 'No title'),
                subtitle: Text(taskData['category'] ?? 'No category'),
              ),
            );
          },
        );
      },
    );
  }
}