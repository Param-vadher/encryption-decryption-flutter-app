import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'utils/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Disable debug banner and performance overlay
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Hide debug overflow banners (yellow/black stripes)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };

  runApp(const EncryptionDecryptionApp());
}

class EncryptionDecryptionApp extends StatelessWidget {
  const EncryptionDecryptionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'SecureCrypt - Encryption & Decryption',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                ThemeMode.light, // Force light theme for professional look
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
