import 'package:flutter/material.dart';
import 'package:moodometer/presentation/shared/speedometer/speedometer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int currentValue = 100;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Mood-O-Meter'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Speedometer(
          minValue: 0,
          maxValue: 100,
          currentValue: currentValue,
          displayText: currentValue <= 10
              ? '😭'
              : currentValue <= 20
                  ? '😢'
                  : currentValue <= 30
                      ? '😐'
                      : currentValue <= 40
                          ? '😊'
                          : currentValue <= 50
                              ? '😄'
                              : currentValue <= 60
                                  ? '😁'
                                  : currentValue <= 70
                                      ? '😀'
                                      : currentValue <= 80
                                          ? '😃'
                                          : currentValue <= 90
                                              ? '😆'
                                              : '😡',
        ),
      ),
    );
  }
}
//🙂, 😃, 😱, 🥳, 😡,