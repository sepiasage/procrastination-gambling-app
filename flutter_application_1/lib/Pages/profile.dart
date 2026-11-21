import 'package:flutter/material.dart';
import 'home_page.dart'; // Adjust if it's directly in lib/ as import 'profile.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {

  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Profiles Page',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
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
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Name'),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Join Date'),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Grade 12'),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Icon(
                      Icons.square_rounded,
                      color: const Color(0xff9a00ff),
                      size: 120,
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
                              tween: Tween<double>(begin: 0, end: .67),
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
                                '67%',
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
                  Row(children: [Text("67%"), Text("Level 5")]),
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
