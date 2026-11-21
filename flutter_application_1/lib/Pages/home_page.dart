import 'package:flutter/material.dart';
import 'profile.dart'; // Adjust if it's directly in lib/ as import 'profile.dart';
import 'calendar.dart';
import 'package:flutter_application_1/Pages/chatbot.dart';

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

  void _showAddTaskModal(BuildContext context) {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController dueDateController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add Task',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                  hintText: 'Input Task Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: dueDateController,
                decoration: InputDecoration(
                  hintText: 'Due Date',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: 'Notes (Optional)...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (taskNameController.text.isNotEmpty) {
                    setState(() {
                      _tasks.add(
                        taskNameController.text,
                      ); // Adds it to your list!
                    });
                    Navigator.pop(context); // Closes the modal
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, int index) {
    final TextEditingController editController = TextEditingController(
      text: _tasks[index],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Update task name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _tasks[index] =
                      editController.text; // Updates the task in the list
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // 4. Function for the "Delete" button (removes the last added task)
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
                            fontSize: 18,
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
                            _showAddTaskModal(context);
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
                children: [
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
                            const Positioned(
                              right: 10,
                              top: 10,
                              child: Text(
                                'Level 1',
                                style: TextStyle(
                                  color: Colors.black,
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
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _tasks.isEmpty
                      ? const Center(
                          child: Text('No tasks yet. Tap + to add one!'),
                        )
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                title: Text(
                                  _tasks[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () =>
                                          _showEditTaskDialog(context, index),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check_box_outline_blank,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _tasks.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
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
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Homepage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const CalendarPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Chatbot(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
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
                    // Navigate to the ProfilePage
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Profilepage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
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
