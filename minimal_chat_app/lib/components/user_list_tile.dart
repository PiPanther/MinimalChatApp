import 'dart:math';

import 'package:flutter/material.dart';

class USerTile extends StatelessWidget {
  const USerTile({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Colors.purple,
      Colors.blue,
      Colors.orange,
      Colors.grey,
    ];

    Color getRandomColor() {
      final random = Random();
      return colors[random.nextInt(colors.length)];
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getRandomColor().withOpacity(.8),
      ),
      child: ListTile(
        leading: ClipRect(
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: getRandomColor(),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              text.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
