import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.pages});

  final Pages pages;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final mushafPageController = PageController(initialPage: 150);
  late final homePageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mushafPageController.dispose();
    homePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: homePageController,
        children: [
          MushafPageView(
            pageController: mushafPageController,
            pages: widget.pages,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
      ),
    );
  }
}
