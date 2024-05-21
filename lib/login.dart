import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/list%20task.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do'),
      ),
      
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login here',
                        style: TextStyle(
                          fontSize: 24, // Increase the font size
                          fontWeight: FontWeight.bold, // Make the text bold
                          color: Colors.black, // Set the text color
                        ),
                      ),
                      SizedBox(height: 100,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true, // Hide the password text
                      ),
                      SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListTask()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          textStyle: TextStyle(fontSize: 20)
                        ),
                        child: Text('Submit'),
                      ),
                      Spacer(), // Pushes the content to the center
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}