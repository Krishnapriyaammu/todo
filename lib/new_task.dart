import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
    String _category = 'Others';
  bool _isSwitched = false;
  int _charCount = 0;
  final int _maxChars = 250;
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: _maxChars,
                      maxLines: null,
                      onChanged: (text) {
                        setState(() {
                          _charCount = text.length;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '$_charCount/$_maxChars',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date:', style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    _selectedDate != null
                        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                        : "Select Date",
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ),
                Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Category: $_category', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryIcon(
                  icon: Icons.home,
                  label: 'Home',
                  selected: _category == 'Home',
                  onTap: () {
                    setState(() {
                      _category = 'Home';
                    });
                  },
                ),
                CategoryIcon(
                  icon: Icons.health_and_safety,
                  label: 'Health',
                  selected: _category == 'Health',
                  onTap: () {
                    setState(() {
                      _category = 'Health';
                    });
                  },
                ),
                CategoryIcon(
                  icon: Icons.work,
                  label: 'Work',
                  selected: _category == 'Work',
                  onTap: () {
                    setState(() {
                      _category = 'Work';
                    });
                  },
                ),
                CategoryIcon(
                  icon: Icons.fitness_center,
                  label: 'Fitness',
                  selected: _category == 'Fitness',
                  onTap: () {
                    setState(() {
                      _category = 'Fitness';
                    });
                  },
                ),
                CategoryIcon(
                  icon: Icons.school,
                  label: 'School',
                  selected: _category == 'School',
                  onTap: () {
                    setState(() {
                      _category = 'School';
                    });
                  },
                ),
                CategoryIcon(
                  icon: Icons.more_horiz,
                  label: 'Others',
                  selected: _category == 'Others',
                  onTap: () {
                    setState(() {
                      _category = 'Others';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text('Save Task'),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _saveTask() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    await tasks.add({
      'title': _titleController.text,
      'category': _category,
      'date': _selectedDate,
      'completed': _isSwitched,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task saved')),
    );

    Navigator.of(context).pop();
  }
}

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  CategoryIcon({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: selected ? Colors.orange : Colors.grey,
            size: 30,
          ),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.orange : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}