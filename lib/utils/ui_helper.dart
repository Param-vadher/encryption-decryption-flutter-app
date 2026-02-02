import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility class for common UI operations
class UIHelper {
  /// Shows a snackbar with a message
  static void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: isError
          ? const Color(0xFFef4444)
          : const Color(0xFF10b981),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Copies text to clipboard and shows confirmation
  static Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    showSnackBar(context, 'Copied to clipboard!');
  }

  /// Shows a dialog with title and message
  static Future<void> showInfoDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFF0891b2),
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(title),
            ],
          ),
          content: Text(message, style: const TextStyle(height: 1.5)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0891b2),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

/// Input validators
class Validators {
  /// Validates if text is not empty
  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  /// Validates if value is a valid integer
  static String? validateInteger(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }

    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Validates if value is a positive integer
  static String? validatePositiveInteger(String? value, String fieldName) {
    final error = validateInteger(value, fieldName);
    if (error != null) return error;

    int intValue = int.parse(value!);
    if (intValue < 0) {
      return '$fieldName must be non-negative';
    }

    return null;
  }

  /// Validates if value contains only letters
  static String? validateLettersOnly(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }

    // Allow letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName must contain only letters';
    }

    return null;
  }
}
