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

  void _isConfirmOrDelete(int index, String newText, bool isConfirm) {
    if(isConfirm) {
      _updateTask(index, newText);
    } else {
      _deleteThisTask(index);
    }
  }

  // Deletes the task for the popup screen.
  void _deleteThisTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Updates the text in the task on the home screen based on what you changed it to in the alert dialog popup.
  void _updateTask(int index, String newText) {
    setState(() {
      _tasks[index] = newText;
    });
    _taskController.clear(); // Clear the text box after adding
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
                        hintText: 'Enter task', // Changed from 'Search'
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
                height: 150,
                child: Card(
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_tasks[index]),
                        trailing: ItemMenu(
                          onSubmit: _isConfirmOrDelete, // Tells if the button is confirm or delete because they affect the actual homepage.
                          index: index, // Index of the item
                          task: _tasks[index], // Item at that index
                        )
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

class ItemMenu extends StatefulWidget {
  final Function(int, String, bool) onSubmit;
  final int index;
  final String task;

  const ItemMenu({super.key,
  required this.onSubmit,
  required this.task,
  required this.index
  });

   @override
  State<ItemMenu> createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  late final TextEditingController _controller;
  late final String oldTask; // This remembers the task that it was when the popup opened, without any edits

  @override
  void initState() { // Initializes the controller and oldTask variables
    super.initState();
    _controller = TextEditingController(text: widget.task);
    oldTask = _controller.text;
  }

  @override
  void dispose() { // Clears the controller after it's done
    _controller.dispose();
    super.dispose();
  }

  void setOldTask() { // Sets the controller value, and therefore the popup text, to the oldTask string for cancel button
    _controller.text = oldTask;
  }

  bool validate(String? text){
    if(text == null || text.isEmpty){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert), // 3 dots icon
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog( // Popup to change the task to a new one
          title: const Text('Task Editor'),
          content: Column( // Body text
            children: [
              Text('Change task below. Cancel restores original task. Confirm changes to what is written below.'),
              TextFormField(
                controller: _controller, // Connected controller here
                decoration: const InputDecoration(
                  helperText: 'Enter task',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Task cannot be blank';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: <Widget>[ // Buttons at the bottom
            TextButton(
              onPressed: () => {
                setOldTask(),
                Navigator.pop(context, 'Cancel')
              },
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () => {
                if(validate(_controller.text)){
                  widget.onSubmit(widget.index, _controller.text, true),
                  Navigator.pop(context, 'Confirm'),
                }else{
                }
              },
              child: const Text('Confirm')
            ),
            TextButton(
              onPressed: () => {
                widget.onSubmit(widget.index, "", false), //delete it, FIX IT
                Navigator.pop(context, 'Delete'),
              },
              child: const Text('Delete')
            ),
          ]
        )
      )
    );
  }
}