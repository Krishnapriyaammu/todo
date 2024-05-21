import 'dart:async';

import 'package:flutter/material.dart';

class TimeDate extends StatefulWidget {
 
  
   TimeDate({super.key,  });

  @override
  State<TimeDate> createState() => TimeDateState();
}

class TimeDateState extends State<TimeDate> {
    late TimeOfDay _startTime;
  late Timer _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.now();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 200,
              child: ListTile(
                title: Text('Select Start Time'),
                subtitle: Text(_formatTime(_startTime)),
                onTap: () {
                  _pickStartTime(context);
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Countdown: $_counter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
        _startCounter();
      });
    }
  }

  void _startCounter() {

    final now = DateTime.now();
    final selectedTime = DateTime(now.year, now.month, now.day, _startTime.hour, _startTime.minute);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
          _counter++;
           });
    });
  }
}
