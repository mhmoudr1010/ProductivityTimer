import 'package:flutter/material.dart';
import 'package:productivity_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;

  TextStyle textStyle = const TextStyle(fontSize: 24);

  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;

  SharedPreferences? prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(20.0),
          children: [
            Text("Work", style: textStyle),
            const Text(""),
            const Text(""),
            SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
                setting: WORKTIME,
                callback: writeSettings),
            TextField(
                controller: txtWork,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
                setting: WORKTIME,
                callback: writeSettings),
            Text("Short", style: textStyle),
            const Text(""),
            const Text(""),
            SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
                setting: SHORTBREAK,
                callback: writeSettings),
            TextField(
                controller: txtShort,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
                setting: SHORTBREAK,
                callback: writeSettings),
            Text("Long", style: textStyle),
            const Text(""),
            const Text(""),
            SettingButton(
                color: Color(0xff455A64),
                text: "-",
                value: -1,
                setting: LONGBREAK,
                callback: writeSettings),
            TextField(
                controller: txtLong,
                style: textStyle,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number),
            SettingButton(
                color: Color(0xff009688),
                text: "+",
                value: 1,
                setting: LONGBREAK,
                callback: writeSettings),
          ],
        ),
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      int? workTime = prefs?.getInt(WORKTIME);
      if (workTime == null) {
        await prefs?.setInt(WORKTIME, int.parse('30'));
      }
      int? shortBreak = prefs?.getInt(SHORTBREAK);
      if (shortBreak == null) {
        await prefs?.setInt(SHORTBREAK, int.parse('5'));
      }
      int? longBreak = prefs?.getInt(LONGBREAK);
      if (longBreak == null) {
        await prefs?.setInt(LONGBREAK, int.parse('20'));
      }
    }
    setState(() {
      txtWork!.text = workTime.toString();
      txtShort!.text = shortBreak.toString();
      txtLong!.text = longBreak.toString();
    });
  }

  void writeSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs?.getInt(WORKTIME);
          if (workTime != null) {
            workTime += value;
            if (workTime >= 1 && workTime <= 180) {
              prefs?.setInt(WORKTIME, workTime);
              setState(() {
                txtWork!.text = workTime.toString();
              });
            }
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs?.getInt(SHORTBREAK);
          if (short != null) {
            short += value;
            if (short >= 1 && short <= 180) {
              prefs?.setInt(SHORTBREAK, short);
              setState(() {
                txtShort!.text = short.toString();
              });
            }
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs?.getInt(LONGBREAK);
          if (long != null) {
            long += value;
            if (long >= 1 && long <= 180) {
              prefs?.setInt(LONGBREAK, long);
              setState(() {
                txtLong!.text = long.toString();
              });
            }
          }
        }
        break;
    }
  }
}
