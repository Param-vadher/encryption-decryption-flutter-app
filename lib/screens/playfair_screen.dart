import 'package:flutter/material.dart';
import '../ciphers/playfair_cipher.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/result_card.dart';
import '../widgets/action_button.dart';
import '../utils/ui_helper.dart';

/// Screen for Playfair Cipher encryption and decryption with 5×5 matrix display
class PlayfairScreen extends StatefulWidget {
  const PlayfairScreen({Key? key}) : super(key: key);

  @override
  State<PlayfairScreen> createState() => _PlayfairScreenState();
}

class _PlayfairScreenState extends State<PlayfairScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _keywordController = TextEditingController();
  final _cipher = PlayfairCipher();
  String _result = '';
  List<List<String>>? _matrix;

  @override
  void dispose() {
    _textController.dispose();
    _keywordController.dispose();
    super.dispose();
  }

  void _generateMatrix() {
    if (_keywordController.text.trim().isEmpty) {
      UIHelper.showSnackBar(
        context,
        'Please enter a keyword first',
        isError: true,
      );
      return;
    }

    try {
      _cipher.generateMatrix(_keywordController.text);
      setState(() {
        _matrix = _cipher.getMatrix();
      });
      UIHelper.showSnackBar(context, '5×5 Matrix generated successfully!');
    } catch (e) {
      UIHelper.showSnackBar(context, 'Error: ${e.toString()}', isError: true);
    }
  }

  void _encrypt() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final text = _textController.text;
      final keyword = _keywordController.text;

      final encrypted = _cipher.encrypt(text, keyword);

      setState(() {
        _result = encrypted;
        _matrix = _cipher.getMatrix();
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
      final keyword = _keywordController.text;

      final decrypted = _cipher.decrypt(text, keyword);

      setState(() {
        _result = decrypted;
        _matrix = _cipher.getMatrix();
      });

      UIHelper.showSnackBar(context, 'Text decrypted successfully!');
    } catch (e) {
      UIHelper.showSnackBar(context, 'Error: ${e.toString()}', isError: true);
    }
  }

  void _clear() {
    setState(() {
      _textController.clear();
      _keywordController.clear();
      _result = '';
      _matrix = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playfair Cipher'), elevation: 0),
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
                  color: Colors.green.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.green[700]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Playfair Cipher uses a 5×5 matrix based on a keyword. Letters I and J are merged.',
                            style: TextStyle(color: Colors.green[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Keyword input
                CustomTextField(
                  controller: _keywordController,
                  label: 'Keyword',
                  hint: 'Enter keyword (letters only)',
                  validator: (value) =>
                      Validators.validateLettersOnly(value, 'Keyword'),
                ),

                const SizedBox(height: 12),

                // Generate matrix button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _generateMatrix,
                    icon: const Icon(Icons.grid_on),
                    label: const Text('Generate 5×5 Matrix'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Matrix display
                if (_matrix != null) ...[
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5×5 Playfair Matrix',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: List.generate(5, (row) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(5, (col) {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: const Color(
                                                0xFF10b981,
                                              ), // Green border
                                              width: 2,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _matrix![row][col],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'monospace',
                                                color: Color(
                                                  0xFF0891b2,
                                                ), // Cyan-blue color for high contrast
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Text input
                CustomTextField(
                  controller: _textController,
                  label: 'Text',
                  hint: 'Enter text to encrypt or decrypt',
                  maxLines: 4,
                  validator: (value) =>
                      Validators.validateNotEmpty(value, 'Text'),
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
                  label: 'Clear All',
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

                // Rules card
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
                              Icons.rule,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Encryption Rules',
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
                          '1. Same Row: Shift right\n'
                          '2. Same Column: Shift down\n'
                          '3. Rectangle: Swap columns\n'
                          '4. Repeated letters get X between them\n'
                          '5. I and J are merged as I',
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
                          'Keyword: MONARCHY\n'
                          'Text: HELLO\n'
                          'Encrypted: DKQRMN',
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
