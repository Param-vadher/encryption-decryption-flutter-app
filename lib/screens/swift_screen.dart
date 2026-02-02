import 'package:flutter/material.dart';
import '../ciphers/swift_cipher.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/result_card.dart';
import '../widgets/action_button.dart';
import '../utils/ui_helper.dart';

/// Screen for Swift Cipher encryption and decryption
class SwiftScreen extends StatefulWidget {
  const SwiftScreen({Key? key}) : super(key: key);

  @override
  State<SwiftScreen> createState() => _SwiftScreenState();
}

class _SwiftScreenState extends State<SwiftScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _textController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  void _encrypt() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final text = _textController.text;
      final key = int.parse(_keyController.text);

      if (key < 0) {
        UIHelper.showSnackBar(
          context,
          'Key must be non-negative',
          isError: true,
        );
        return;
      }

      final encrypted = SwiftCipher.encrypt(text, key);

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
      final key = int.parse(_keyController.text);

      if (key < 0) {
        UIHelper.showSnackBar(
          context,
          'Key must be non-negative',
          isError: true,
        );
        return;
      }

      final decrypted = SwiftCipher.decrypt(text, key);

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
      _keyController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swift Cipher'), elevation: 0),
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
                  color: Colors.orange.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Swift Cipher is an enhanced shift cipher with strict validation and positive key requirement.',
                            style: TextStyle(color: Colors.orange[700]),
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

                // Key input
                CustomTextField(
                  controller: _keyController,
                  label: 'Key / Shift Value',
                  hint: 'Enter key value (must be ≥ 0)',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      Validators.validatePositiveInteger(value, 'Key'),
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

                // Features card
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
                              Icons.verified_outlined,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Features',
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
                          '✓ Forward character shifting\n'
                          '✓ Reverse shifting for decryption\n'
                          '✓ Separate uppercase/lowercase handling\n'
                          '✓ Preserves spaces and symbols\n'
                          '✓ Strict key validation',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Example card
                Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
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
                              ).colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Example',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondaryContainer,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Text: Swift Cipher\nKey: 5\nEncrypted: Xbnky Hnumjw',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Theme.of(
                              context,
                            ).colorScheme.onSecondaryContainer,
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
