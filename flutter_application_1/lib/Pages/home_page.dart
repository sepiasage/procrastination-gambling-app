import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

   @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // 2. Controller to read what you type, and a list to store tasks
  final TextEditingController _taskController = TextEditingController();
  final List<String> _tasks = [];

  // 3. Function for the "Add Task" button
  void _addTask() {
    final text = _taskController.text.trim();
    if (text.isEmpty) return; // Don't add empty tasks

    setState(() {
      _tasks.add(text);
    });
    _taskController.clear(); // Clear the text box after adding
  }

  // 4. Function for the "Delete" button (removes the last added task)
  void _deleteLastTask() {
    if (_tasks.isEmpty) return;

    setState(() {
      _tasks.removeLast();
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'To Do List';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          // 5. Wrapped in a Column so the list can sit below your Row
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _taskController, // Connected controller here
                      decoration: const InputDecoration(
                        hintText: 'Enter a task', // Changed from 'Search'
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 6. Replaced "null" with your functions
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text('Add Task'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _tasks.isEmpty ? null : _deleteLastTask,
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 7. Displays your added tasks on screen
              SizedBox(
                width: 300,
                height: 150,
                child: Card(
                  clipBehavior: .hardEdge,
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_tasks[index]),
                        //trailing: ItemMenu(title: _tasks[index])
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final String title;
  const ItemMenu({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: const Text('Here you can edit your item.'), // Change Item, it's not the right word
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Edit'),
              child: const Text('Edit')
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Completed'),
              child: const Text('Completed')
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Exit'),
              child: const Text('Exit')
            ),
          ]
        )
      )
    );
  }
}