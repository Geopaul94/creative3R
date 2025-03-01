import 'package:creative/presentation/widgets/CustomeAppbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(title: 
    'home screen'),
        body: Column(
          children: [
            Text('Home Screen', style: TextStyle(fontSize: 24)),
          ],
        ));
  }
}
