import 'package:flutter/material.dart';
import '../widgets/cipher_card.dart';
import 'caesar_screen.dart';
import 'swift_screen.dart';
import 'playfair_screen.dart';

/// Home screen with navigation to different cipher methods
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Professional App Bar
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF0891b2),
                        const Color(0xFF10b981),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Logo
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          size: 35,
                          color: Color(0xFF0891b2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'SecureCrypt',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Classical Cryptography Suite',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  onPressed: () => _showAboutDialog(context),
                  tooltip: 'About',
                ),
              ],
            ),

            // Content
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome section
                      Text(
                        'Choose Your Cipher',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1a1a1a),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select a cryptography method to secure your messages',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF4a5568),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Caesar Cipher Card
                      CipherCard(
                        title: 'Caesar Cipher',
                        description: 'Classic shift-based encryption',
                        icon: Icons.shield_outlined,
                        color: const Color(0xFF0891b2),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CaesarScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Swift Cipher Card
                      CipherCard(
                        title: 'Swift Cipher',
                        description: 'Enhanced shift with validation',
                        icon: Icons.flash_on_outlined,
                        color: const Color(0xFF10b981),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SwiftScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Playfair Cipher Card
                      CipherCard(
                        title: 'Playfair Cipher',
                        description: 'Matrix-based digraph encryption',
                        icon: Icons.grid_4x4_outlined,
                        color: const Color(0xFF06b6d4),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlayfairScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Footer
                      Center(
                        child: Text(
                          '© 2026 SecureCrypt • Made with ❤️',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF0891b2)),
            SizedBox(width: 12),
            Text('About SecureCrypt'),
          ],
        ),
        content: const Text(
          'SecureCrypt is a professional tool for classical cryptography.\n\n'
          'Features:\n'
          '🔒 Caesar Cipher - Classic shift encryption\n'
          '⚡ Swift Cipher - Enhanced shift method\n'
          '🔢 Playfair Cipher - Matrix-based encryption\n\n'
          'Version 1.0.0',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
