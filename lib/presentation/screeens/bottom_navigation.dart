import 'package:creative/presentation/screeens/home_screen.dart';
import 'package:creative/presentation/screeens/more_screen.dart';
import 'package:creative/presentation/screeens/news_screen.dart';
import 'package:creative/presentation/screeens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigationDrop extends StatefulWidget {
  final int index;

  const BottomNavigationDrop({super.key, this.index = 0});

  @override
  BottomNavigationdropState createState() => BottomNavigationdropState();
}

class BottomNavigationdropState extends State<BottomNavigationDrop> {
  final Color navigationBarColor = Colors.black;
  late int selectedIndex;
  late PageController pageController;

  // Custom color scheme
  final Color activeColor = Colors.amber[400]!;
  final Color inactiveColor = Colors.amber[100]!;
  final Color waterDropColor = Colors.amber[700]!;
  final Color navigationBarBorderColor = Colors.amber[800]!;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    pageController = PageController(initialPage: widget.index);
  }

  @override
  void didUpdateWidget(BottomNavigationDrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      selectedIndex = widget.index;
      pageController.jumpToPage(widget.index);
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    NewsScreen(),
    ProfileScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: _screens,
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor.withOpacity(0.95),
          waterDropColor: waterDropColor,
          iconSize: 28,
          inactiveIconColor: inactiveColor,
          barItems: [
            BarItem(
              filledIcon: CupertinoIcons.home,
              outlinedIcon: CupertinoIcons.home,
            ),
            BarItem(
              filledIcon: Icons.article,
              outlinedIcon: Icons.article_outlined,
            ),
            BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outline,
            ),
            BarItem(
              filledIcon: Icons.more_horiz,
              outlinedIcon: Icons.more_horiz_outlined,
            ),
          ],
          selectedIndex: selectedIndex,
          onItemSelected: (int index) {
            setState(() => selectedIndex = index);
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad,
            );
          },
        )
            .box
            .withShadow([
              BoxShadow(
                color: Colors.amber.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, -4),
              )
            ])
            .withDecoration(
              BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: navigationBarBorderColor,
                    width: 0.5,
                  ),
                ),
              ),
            )
            .make(),
      ),
    );
  }
}
