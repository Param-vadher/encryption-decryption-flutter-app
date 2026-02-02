/// Playfair Cipher implementation with 5x5 matrix
/// Encrypts and decrypts text using keyword-based matrix substitution
class PlayfairCipher {
  late List<List<String>> matrix;
  late Map<String, List<int>> positions;

  /// Generates the 5x5 Playfair matrix from a keyword
  ///
  /// [keyword] - The keyword to generate the matrix
  void generateMatrix(String keyword) {
    // Remove spaces and convert to uppercase
    keyword = keyword.replaceAll(' ', '').toUpperCase();

    if (keyword.isEmpty) {
      throw ArgumentError('Keyword cannot be empty');
    }

    // Validate keyword contains only letters
    if (!RegExp(r'^[A-Z]+$').hasMatch(keyword)) {
      throw ArgumentError('Keyword must contain only letters');
    }

    // Replace J with I
    keyword = keyword.replaceAll('J', 'I');

    // Create a set to store unique characters
    Set<String> uniqueChars = {};
    List<String> matrixChars = [];

    // Add unique characters from keyword
    for (int i = 0; i < keyword.length; i++) {
      String char = keyword[i];
      if (!uniqueChars.contains(char)) {
        uniqueChars.add(char);
        matrixChars.add(char);
      }
    }

    // Add remaining letters of alphabet (excluding J)
    for (int i = 65; i <= 90; i++) {
      String char = String.fromCharCode(i);
      if (char != 'J' && !uniqueChars.contains(char)) {
        uniqueChars.add(char);
        matrixChars.add(char);
      }
    }

    // Create 5x5 matrix
    matrix = List.generate(5, (i) => List.filled(5, ''));
    positions = {};

    int index = 0;
    for (int row = 0; row < 5; row++) {
      for (int col = 0; col < 5; col++) {
        String char = matrixChars[index];
        matrix[row][col] = char;
        positions[char] = [row, col];
        index++;
      }
    }
  }

  /// Prepares text for encryption
  /// Converts to uppercase, replaces J with I, removes non-letters
  String _prepareText(String text) {
    text = text.toUpperCase().replaceAll('J', 'I');
    text = text.replaceAll(RegExp(r'[^A-Z]'), '');
    return text;
  }

  /// Formats text into digraphs (pairs of letters)
  /// Inserts X between repeated letters
  List<String> _formatIntoDigraphs(String text) {
    List<String> digraphs = [];
    int i = 0;

    while (i < text.length) {
      String first = text[i];
      String second = '';

      if (i + 1 < text.length) {
        second = text[i + 1];

        // If letters are same, insert X
        if (first == second) {
          second = 'X';
          i++;
        } else {
          i += 2;
        }
      } else {
        // Odd length, add X at the end
        second = 'X';
        i++;
      }

      digraphs.add(first + second);
    }

    return digraphs;
  }

  /// Encrypts a digraph using Playfair rules
  String _encryptDigraph(String digraph) {
    String first = digraph[0];
    String second = digraph[1];

    List<int> pos1 = positions[first]!;
    List<int> pos2 = positions[second]!;

    int row1 = pos1[0], col1 = pos1[1];
    int row2 = pos2[0], col2 = pos2[1];

    // Same row - shift right
    if (row1 == row2) {
      return matrix[row1][(col1 + 1) % 5] + matrix[row2][(col2 + 1) % 5];
    }
    // Same column - shift down
    else if (col1 == col2) {
      return matrix[(row1 + 1) % 5][col1] + matrix[(row2 + 1) % 5][col2];
    }
    // Rectangle - swap columns
    else {
      return matrix[row1][col2] + matrix[row2][col1];
    }
  }

  /// Decrypts a digraph using Playfair rules
  String _decryptDigraph(String digraph) {
    String first = digraph[0];
    String second = digraph[1];

    List<int> pos1 = positions[first]!;
    List<int> pos2 = positions[second]!;

    int row1 = pos1[0], col1 = pos1[1];
    int row2 = pos2[0], col2 = pos2[1];

    // Same row - shift left
    if (row1 == row2) {
      return matrix[row1][(col1 - 1 + 5) % 5] +
          matrix[row2][(col2 - 1 + 5) % 5];
    }
    // Same column - shift up
    else if (col1 == col2) {
      return matrix[(row1 - 1 + 5) % 5][col1] +
          matrix[(row2 - 1 + 5) % 5][col2];
    }
    // Rectangle - swap columns
    else {
      return matrix[row1][col2] + matrix[row2][col1];
    }
  }

  /// Encrypts plain text using Playfair Cipher
  ///
  /// [text] - The plain text to encrypt
  /// [keyword] - The keyword to generate the matrix
  /// Returns encrypted cipher text
  String encrypt(String text, String keyword) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    generateMatrix(keyword);

    String preparedText = _prepareText(text);
    if (preparedText.isEmpty) {
      throw ArgumentError('Text must contain at least one letter');
    }

    List<String> digraphs = _formatIntoDigraphs(preparedText);
    StringBuffer result = StringBuffer();

    for (String digraph in digraphs) {
      result.write(_encryptDigraph(digraph));
    }

    return result.toString();
  }

  /// Decrypts cipher text using Playfair Cipher
  ///
  /// [text] - The cipher text to decrypt
  /// [keyword] - The keyword used for encryption
  /// Returns decrypted plain text
  String decrypt(String text, String keyword) {
    if (text.isEmpty) {
      throw ArgumentError('Text cannot be empty');
    }

    generateMatrix(keyword);

    String preparedText = _prepareText(text);
    if (preparedText.isEmpty) {
      throw ArgumentError('Text must contain at least one letter');
    }

    // Cipher text should already be in digraphs
    if (preparedText.length % 2 != 0) {
      throw ArgumentError('Cipher text must have even length');
    }

    StringBuffer result = StringBuffer();

    for (int i = 0; i < preparedText.length; i += 2) {
      String digraph = preparedText.substring(i, i + 2);
      result.write(_decryptDigraph(digraph));
    }

    return result.toString();
  }

  /// Returns the 5x5 matrix as a 2D list
  List<List<String>> getMatrix() {
    return matrix;
  }

  /// Returns a formatted string representation of the matrix
  String getMatrixString() {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < 5; i++) {
      sb.write(matrix[i].join('  '));
      if (i < 4) sb.write('\n');
    }
    return sb.toString();
  }
}
