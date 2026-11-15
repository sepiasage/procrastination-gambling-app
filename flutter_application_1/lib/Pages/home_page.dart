import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //keep track of what page we are on
  int _currentIndex = 0; // 0 for home/tasks, 1 for calendar, etc.
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
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 600,
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        //box decoration for the container
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Good evening, User Name!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //space betwween the 2 widgets
                  const SizedBox(width: 10),
                  //second container
                  Expanded(
                    child: Container(
                      width: 600,
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        //box decoration for the container
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(Icons.add_sharp),
                          iconSize: 50,

                          color: Colors.black,
                          onPressed: () {
                            // Navigate to add task page
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children:[
              Expanded(
                flex: 3,
                child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 0.1),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        //animation for the progress bar
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1.0),
                          duration: const Duration(seconds: 5),
                          builder: (context, value, child) {
                            return FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: value,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            );
                          },
                        ),
                        //percent text
                        const Center(
                          child: Text(
                            '100%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
            ],
          ),
          ],
          ),
        ),
        
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.assignment_turned_in,
                    color: _currentIndex == 0 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    // Navigate to home page
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_month,
                    color: _currentIndex == 1 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    // Navigate to calendar page
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.support_agent,
                    color: _currentIndex == 2 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    // Navigate to chatbot page
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _currentIndex == 3 ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    // Navigate to settings page
                    setState(() {
                      _currentIndex = 3;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
