import 'package:flutter/material.dart';
class Homepage extends StatelessWidget{
  const new ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
                Row(searchBar: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your button action here
                      },
                      child: const Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add your button action here
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}