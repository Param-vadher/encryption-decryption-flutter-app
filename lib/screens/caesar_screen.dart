import 'package:flutter/material.dart';
import '../ciphers/caesar_cipher.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/result_card.dart';
import '../widgets/action_button.dart';
import '../utils/ui_helper.dart';

/// Screen for Caesar Cipher encryption and decryption
class CaesarScreen extends StatefulWidget {
  const CaesarScreen({Key? key}) : super(key: key);

  @override
  State<CaesarScreen> createState() => _CaesarScreenState();
}

class _CaesarScreenState extends State<CaesarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _shiftController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _textController.dispose();
    _shiftController.dispose();
    super.dispose();
  }

  void _encrypt() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final text = _textController.text;
      final shift = int.parse(_shiftController.text);

      final encrypted = CaesarCipher.encrypt(text, shift);

      setState(() {
        _result = encrypted;
      });

      UIHelper.showSnackBar(context, 'Text encrypted successfully!');
    } catch (e) {
      UIHelper.showSnackBar(context, 'Error: ${e.toString()}', isError: true);
    }
  }

  void _decrypt() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final text = _textController.text;
      final shift = int.parse(_shiftController.text);

      final decrypted = CaesarCipher.decrypt(text, shift);

      setState(() {
        _result = decrypted;
      });

      UIHelper.showSnackBar(context, 'Text decrypted successfully!');
    } catch (e) {
      UIHelper.showSnackBar(context, 'Error: ${e.toString()}', isError: true);
    }
  }

  void _clear() {
    setState(() {
      _textController.clear();
      _shiftController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caesar Cipher'), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info card
                Card(
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Caesar Cipher shifts each letter by a fixed number of positions in the alphabet.',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Text input
                CustomTextField(
                  controller: _textController,
                  label: 'Text',
                  hint: 'Enter text to encrypt or decrypt',
                  maxLines: 4,
                  validator: (value) =>
                      Validators.validateNotEmpty(value, 'Text'),
                ),

                const SizedBox(height: 16),

                // Shift key input
                CustomTextField(
                  controller: _shiftController,
                  label: 'Shift Key',
                  hint: 'Enter shift value (e.g., 3)',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validators.validateInteger(value, 'Shift key'),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ActionButton(
                        label: 'Encrypt',
                        icon: Icons.lock,
                        onPressed: _encrypt,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ActionButton(
                        label: 'Decrypt',
                        icon: Icons.lock_open,
                        onPressed: _decrypt,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                ActionButton(
                  label: 'Clear',
                  icon: Icons.clear,
                  onPressed: _clear,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),

                const SizedBox(height: 24),

                // Result display
                ResultCard(title: 'Result', result: _result),

                const SizedBox(height: 16),

                // Example card
                Card(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.tips_and_updates,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Example',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onTertiaryContainer,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Text: HELLO\nShift: 3\nEncrypted: KHOOR',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Theme.of(
                              context,
                            ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
