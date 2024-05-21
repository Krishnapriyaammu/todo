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
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Now'),
        actions: [
          IconButton(
            icon: Icon(Icons.card_giftcard),
            onPressed: () {
              // Add action for the gift icon
            },
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Chip(
              label: Text(
                '25',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              text:
                  'Write down your (maximum 6) most important tasks',
            ),
            TaskStep(
              icon: Icons.check_circle,
              text:
                  'Prioritize tasks from most to least important',
            ),
            TaskStep(
              icon: Icons.check_circle,
              text:
                  'Start completing your list from the top down.',
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