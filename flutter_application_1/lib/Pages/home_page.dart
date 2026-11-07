import 'package:flutter/material.dart';

class Homepage extends StatelessWidget{
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'To Do List';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: null,
                            child: Text('Add'),
                          ),
                          ElevatedButton(
                            onPressed: null,
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ]
                  )
                ]
              )
            ]
          )
        ),
      ),
    );
  }
}