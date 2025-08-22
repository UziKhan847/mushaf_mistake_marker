import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';
import 'package:mushaf_mistake_marker/page_data/pages.dart';
import 'package:mushaf_mistake_marker/widgets/custom_flex.dart';
import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/custom_nav_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.pages});

  final Pages pages;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final mushafPageController = PageController(initialPage: 150);
  late final pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mushafPageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFlex(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  MushafPageView(
                    pageController: mushafPageController,
                    pages: widget.pages,
                    constraints: constraints,
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.redAccent,
                        width: double.infinity,
                        height: 500,
                      ),
                    ],
                  ),
                  Container(color: Colors.blueAccent),
                  Container(color: Colors.amberAccent),
                ],
              );
            },
          ),
        ),
        CustomNavBar(pageController: pageController),
      ],
    );
  }
}
