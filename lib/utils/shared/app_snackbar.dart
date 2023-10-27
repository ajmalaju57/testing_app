import 'package:flutter/material.dart';
import 'package:test_eco/ui/components/app_text.dart';

enum MessageType { error, success, warning }

void snackBar(BuildContext context,
    {required String message, MessageType type = MessageType.error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: _getColor(type),
      content: AppText(
        size: 12,
        message.toUpperCase(),
        color: Colors.white,
        maxLines: 2,
      ),
    ),
  );
}

Color _getColor(MessageType type) {
  if (type == MessageType.error) {
    return Colors.red[600]!;
  } else if (type == MessageType.success) {
    return Colors.green[600]!;
  }
  return Colors.black;
}
