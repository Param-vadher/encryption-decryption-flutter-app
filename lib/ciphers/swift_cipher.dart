/// Swift Cipher implementation
/// Similar to Caesar Cipher but with additional validation and handling
class SwiftCipher {
  /// Encrypts plain text using Swift Cipher
  ///
  /// [text] - The plain text to encrypt
  /// [key] - The shift value (must be positive)
  /// Returns encrypted cipher text
  static String encrypt(String text, int key) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    if (key < 0) {
      throw ArgumentError('Key must be non-negative');
    }

    // Normalize key to 0-25 range
    key = key % 26;

    StringBuffer result = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String char = text[i];

      if (char.toUpperCase() != char.toLowerCase()) {
        // It's a letter
        if (char == char.toUpperCase()) {
          // Uppercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 65 + key) % 26) + 65;
          result.write(String.fromCharCode(shifted));
        } else {
          // Lowercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 97 + key) % 26) + 97;
          result.write(String.fromCharCode(shifted));
        }
      } else {
        // Not a letter (space, number, special character)
        result.write(char);
      }
    }

    return result.toString();
  }

  /// Decrypts cipher text using Swift Cipher
  ///
  /// [text] - The cipher text to decrypt
  /// [key] - The shift value that was used for encryption
  /// Returns decrypted plain text
  static String decrypt(String text, int key) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    if (key < 0) {
      throw ArgumentError('Key must be non-negative');
    }

    // Normalize key to 0-25 range
    key = key % 26;

    // Reverse the shift for decryption
    int reverseKey = (26 - key) % 26;

    StringBuffer result = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String char = text[i];

      if (char.toUpperCase() != char.toLowerCase()) {
        // It's a letter
        if (char == char.toUpperCase()) {
          // Uppercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 65 + reverseKey) % 26) + 65;
          result.write(String.fromCharCode(shifted));
        } else {
          // Lowercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 97 + reverseKey) % 26) + 97;
          result.write(String.fromCharCode(shifted));
        }
      } else {
        // Not a letter (space, number, special character)
        result.write(char);
      }
    }

    return result.toString();
  }

  /// Validates if the key is valid
  static bool isValidKey(int key) {
    return key >= 0;
  }
}
