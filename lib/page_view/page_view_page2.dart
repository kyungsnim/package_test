import 'package:flutter/material.dart';

class PageViewPage2 extends StatefulWidget {
  const PageViewPage2({super.key});

  @override
  State<PageViewPage2> createState() => _PageViewPage2State();
}

class _PageViewPage2State extends State<PageViewPage2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              height: 200,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
