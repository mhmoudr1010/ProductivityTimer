import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

import './Timer.dart';
import './timer_model.dart';
import './settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({super.key});

  final double defaultPadding = 5.0;

  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItem = <PopupMenuItem<String>>[];
    menuItem.add(
      const PopupMenuItem(
        value: "Settings",
        child: Text("Settings"),
      ),
    );

    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Work Timer"),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return menuItem;
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        return Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff009688),
                    text: "Work",
                    size: 10,
                    onPressed: () => timer.startWork(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff607D8B),
                    text: "Short Break",
                    size: 10,
                    onPressed: () => timer.startBreak(true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff455A64),
                    text: "Long Break",
                    size: 20,
                    onPressed: () => timer.startBreak(false),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<TimerModel>(
                  initialData: TimerModel("00:00", 1),
                  stream: timer.stream(),
                  builder: (context, snapshot) {
                    TimerModel? timer = snapshot.data;
                    return CircularPercentIndicator(
                      radius: availableWidth / 2,
                      lineWidth: 10,
                      percent: (timer?.percent == null) ? 1 : timer!.percent,
                      center: Text(
                        (timer?.time == null) ? '00:00' : timer!.time,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      progressColor: Color(0xff009688),
                    );
                  }),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff212121),
                    text: 'Stop',
                    size: 10,
                    onPressed: () => timer.stopTimer(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff009688),
                    text: 'Start',
                    size: 10,
                    onPressed: () => timer.startTimer(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  void emptyMethod() {}

  void goToSettings(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ));
  }
}
