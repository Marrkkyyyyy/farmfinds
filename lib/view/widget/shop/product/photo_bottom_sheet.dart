import 'package:flutter/material.dart';

void customModalBottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return widget;
    },
  );
}
