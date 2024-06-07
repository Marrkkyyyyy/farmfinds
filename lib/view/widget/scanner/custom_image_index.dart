import 'package:flutter/material.dart';

class CustomImageIndex extends StatelessWidget {
  const CustomImageIndex(
      {super.key, required this.imageURLs, required this.currentIndex});
  final List<String> imageURLs;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageURLs.asMap().entries.map((entry) {
          final int index = entry.key;
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.teal : Colors.grey.shade400,
            ),
          );
        }).toList(),
      ),
    );
  }
}
