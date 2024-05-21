import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
   Counter({super.key,});

  @override
  State<Counter> createState() => CounterState();
}

class CounterState extends State<Counter> {
  int counter = 0;

  void counterplus() {
    setState(() {
      
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
  
       
      ),
      body: Center(
       
        child: Column(
     
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
           
            Center(
              child: Text(
                '$counter',
              ),
            ),
          ],
        ),
        
      ),
      
      floatingActionButton: Center(
        child: ElevatedButton(
          onPressed: counterplus,
          child: const Icon(Icons.add),
        ),
      ), 
    );
  }
}
