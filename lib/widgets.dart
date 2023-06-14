import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  const ProductivityButton({
    super.key,
    required this.color,
    required this.text,
    required this.size,
    required this.onPressed,
  });

  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  SettingButton({
    super.key,
    required this.color,
    required this.text,
    required this.value,
    required this.setting,
    required this.callback,
  });

  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: () => callback(setting, value),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
