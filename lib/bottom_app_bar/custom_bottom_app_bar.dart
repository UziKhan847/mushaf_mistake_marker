import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF004D40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.book, color: Color(0xFFDAB77D)),
          ),
          Icon(Icons.search, color: Color(0xFFDAB77D)),
          Icon(Icons.settings, color: Color(0xFFDAB77D)),
          Icon(Icons.person, color: Color(0xFFDAB77D)),
        ],
      ),
    );
  }
}
