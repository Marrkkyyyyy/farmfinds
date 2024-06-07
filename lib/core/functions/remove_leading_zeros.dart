import 'package:flutter/services.dart';

class RemoveLeadingZerosFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove leading zeros from the input
    final trimmedValue = newValue.text.replaceFirst(RegExp('^0+'), '');

    return TextEditingValue(
      text: trimmedValue,
      selection: TextSelection.collapsed(offset: trimmedValue.length),
    );
  }
}
