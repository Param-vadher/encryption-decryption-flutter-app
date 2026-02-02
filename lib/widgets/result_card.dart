import 'package:flutter/material.dart';
import '../utils/ui_helper.dart';

/// Widget to display the result of encryption/decryption
class ResultCard extends StatelessWidget {
  final String title;
  final String result;

  const ResultCard({Key? key, required this.title, required this.result})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (result.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.copy),
                    color: const Color(0xFF0891b2),
                    onPressed: () {
                      UIHelper.copyToClipboard(context, result);
                    },
                    tooltip: 'Copy to clipboard',
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDFA),
                border: Border.all(
                  color: const Color(0xFF0891b2).withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                result.isEmpty ? 'Result will appear here' : result,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontFamily: 'monospace',
                  color: const Color(0xFF1a1a1a),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
