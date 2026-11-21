import 'package:flutter/material.dart';
import 'profile.dart'; // Adjust if it's directly in lib/ as import 'profile.dart';
import 'calendar.dart';
import 'home_page.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotSpace();
}

class _ChatbotSpace extends State<Chatbot> {
  // Moved _currentIndex here so setState works properly
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      body: const Center(child: Text('Chatbot Page Content')),
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
                  setState(() {
                    _currentIndex = 3;
                  });
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
    );
  }
}
