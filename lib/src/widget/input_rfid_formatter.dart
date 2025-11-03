import 'package:flutter/services.dart';

class RfidInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';
    if (digits.isNotEmpty) {
      if (digits.length <= 3) {
        formatted = digits;
      } else {
        formatted =
            digits.substring(0, 3) + '-' + digits.substring(3, digits.length);
      }
    }

    if (formatted.length > 19) {
      formatted = formatted.substring(0, 19);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
