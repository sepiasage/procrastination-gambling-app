import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

Widget build(BuildContext context) {
  return MaterialApp(
    title: appTitle,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children:[
                    Text('Name'),
                    Text('Join Date'),
                    Text('Grade 12'),
                  ],
                  Icon(Icons.square_rounded,
                  color: const Color(0xff9a00ff), size: 120),
                ),
              ],
            ),
              Row(
                children:[
                  Text("67%"),
                  Text("Level 5"),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}