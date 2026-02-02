/// Caesar Cipher implementation
/// Encrypts and decrypts text by shifting characters by a specified key
class CaesarCipher {
  /// Encrypts plain text using Caesar Cipher
  ///
  /// [text] - The plain text to encrypt
  /// [shift] - The number of positions to shift (can be positive or negative)
  /// Returns encrypted cipher text
  static String encrypt(String text, int shift) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    // Normalize shift to 0-25 range
    shift = shift % 26;
    if (shift < 0) shift += 26;

    StringBuffer result = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String char = text[i];

      if (char.toUpperCase() != char.toLowerCase()) {
        // It's a letter
        if (char == char.toUpperCase()) {
          // Uppercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 65 + shift) % 26) + 65;
          result.write(String.fromCharCode(shifted));
        } else {
          // Lowercase letter
          int charCode = char.codeUnitAt(0);
          int shifted = ((charCode - 97 + shift) % 26) + 97;
          result.write(String.fromCharCode(shifted));
        }
      } else {
        // Not a letter (space, number, special character)
        result.write(char);
      }
    }

    return result.toString();
  }

  /// Decrypts cipher text using Caesar Cipher
  ///
  /// [text] - The cipher text to decrypt
  /// [shift] - The number of positions that was used for encryption
  /// Returns decrypted plain text
  static String decrypt(String text, int shift) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    // Decryption is encryption with negative shift
    return encrypt(text, -shift);
  }

  /// Validates if the shift key is within acceptable range
  static bool isValidShift(int shift) {
    return shift >= -25 && shift <= 25;
  }
}
